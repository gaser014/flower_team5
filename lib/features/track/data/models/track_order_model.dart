import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flowers_app/features/track/domain/entities/track_lat_lng_entity.dart';
import 'package:flowers_app/features/track/domain/entities/track_order_entity.dart';

/// Maps the Firebase `orders/{orderId}` document (written by the driver app)
/// into the domain [TrackOrderEntity]. Parsing is defensive because fields may
/// be absent while the order is still pending.
class TrackOrderModel {
  final String id;
  final String orderNumber;
  final String status;
  final String paymentType;
  final num totalPrice;
  final Map<String, dynamic> store;
  final Map<String, dynamic> customer;
  final Map<String, dynamic> driver;
  final List<dynamic> items;
  final dynamic driverLocation;
  final DateTime? updatedAt;

  const TrackOrderModel({
    required this.id,
    this.orderNumber = '',
    this.status = 'pending',
    this.paymentType = '',
    this.totalPrice = 0,
    this.store = const {},
    this.customer = const {},
    this.driver = const {},
    this.items = const [],
    this.driverLocation,
    this.updatedAt,
  });

  static Map<String, dynamic> _asMap(dynamic value) =>
      value is Map ? Map<String, dynamic>.from(value) : const {};

  factory TrackOrderModel.fromFirestore(String id, Map<String, dynamic> json) {
    final updatedAtRaw = json['updatedAt'];
    return TrackOrderModel(
      id: (json['orderId'] ?? json['_id'] ?? json['id'] ?? id).toString(),
      orderNumber: (json['orderNumber'] ?? '')
          .toString()
          .replaceAll('#', '')
          .trim(),
      status: (json['status'] ?? json['state'] ?? 'pending').toString(),
      paymentType: (json['paymentType'] ?? '').toString(),
      totalPrice: json['totalPrice'] is num ? json['totalPrice'] as num : 0,
      store: _asMap(json['store']),
      customer: _asMap(json['customer']),
      driver: _asMap(json['driver']),
      items: json['items'] is List ? json['items'] as List : const [],
      driverLocation: json['driverLocation'],
      updatedAt: updatedAtRaw is Timestamp ? updatedAtRaw.toDate() : null,
    );
  }

  TrackOrderEntity toEntity() {
    final driverLoc =
        TrackLatLngEntity.fromDynamic(driverLocation) ??
        TrackLatLngEntity.fromDynamic(driver['location']) ??
        TrackLatLngEntity.fromDynamic(driver);

    return TrackOrderEntity(
      id: id,
      orderNumber: orderNumber,
      status: TrackOrderStatus.fromString(status),
      paymentType: paymentType,
      totalPrice: totalPrice,
      store: TrackStoreEntity(
        name: (store['name'] ?? '').toString(),
        address: (store['address'] ?? '').toString(),
        phone: (store['phone'] ?? store['phoneNumber'] ?? '').toString(),
        location: TrackLatLngEntity.fromDynamic(store),
      ),
      customer: TrackCustomerEntity(
        name: (customer['name'] ?? '').toString(),
        address: (customer['address'] ?? '').toString(),
        phone: (customer['phone'] ?? '').toString(),
        location: TrackLatLngEntity.fromDynamic(customer),
      ),
      driver: TrackDriverEntity(
        id: (driver['id'] ?? '').toString(),
        name: (driver['name'] ?? '').toString(),
        phone: (driver['phone'] ?? '').toString(),
        photo: (driver['photo'] ?? '').toString(),
        location: TrackLatLngEntity.fromDynamic(driver['location']),
      ),
      items: items
          .whereType<Map>()
          .map(
            (item) => TrackOrderItemEntity(
              name: (item['name'] ?? '').toString(),
              image: (item['image'] ?? '').toString(),
              price: item['price'] is num ? item['price'] as num : 0,
              quantity: item['quantity'] is num
                  ? (item['quantity'] as num).toInt()
                  : 1,
            ),
          )
          .toList(growable: false),
      driverLocation: driverLoc,
      updatedAt: updatedAt,
    );
  }
}
