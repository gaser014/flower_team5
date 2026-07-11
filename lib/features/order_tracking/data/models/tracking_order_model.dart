import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flowers_app/features/order_tracking/domain/entities/lat_lng_entity.dart';
import 'package:flowers_app/features/order_tracking/domain/entities/tracking_order_entity.dart';

class TrackingOrderModel {
  const TrackingOrderModel._();

  static TrackingOrderEntity fromFirestore(
    Map<String, dynamic> data,
    String docId,
  ) {
    final store = _asMap(data['store']);
    final customer = _asMap(data['customer']);
    final driver = _asMap(data['driver']);

    return TrackingOrderEntity(
      orderId: (data['orderId'] ?? docId).toString(),
      orderNumber: (data['orderNumber'] ?? '').toString(),
      status: (data['status'] ?? '').toString(),
      storeLocation:
          LatLngEntity.fromDynamic(store) ??
          LatLngEntity.fromDynamic(data['store']),
      userLocation:
          LatLngEntity.fromDynamic(customer) ??
          LatLngEntity.fromDynamic(data['customer']),
      driverLocation:
          LatLngEntity.fromDynamic(data['driverLocation']) ??
          LatLngEntity.fromDynamic(driver['location']),
      storeName: (store['name'] ?? '').toString(),
      customerName: (customer['name'] ?? '').toString(),
      customerAddress: (customer['address'] ?? '').toString(),
      driverName: (driver['name'] ?? '').toString(),
      driverPhone: (driver['phone'] ?? driver['phoneNumber'] ?? '').toString(),
      driverPhoto: (driver['photo'] ?? '').toString(),
      estimatedArrival: _parseDate(
        data['estimatedArrival'] ?? data['estimatedArrivalAt'],
      ),
    );
  }

  static Map<String, dynamic> _asMap(dynamic value) {
    if (value is Map) return value.cast<String, dynamic>();
    return const {};
  }

  static DateTime? _parseDate(dynamic value) {
    if (value == null) return null;
    if (value is Timestamp) return value.toDate();
    if (value is DateTime) return value;
    if (value is int) {
      return DateTime.fromMillisecondsSinceEpoch(value);
    }
    if (value is String) return DateTime.tryParse(value);
    return null;
  }
}
