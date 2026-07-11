import 'package:equatable/equatable.dart';
import 'package:flowers_app/features/track/domain/entities/track_lat_lng_entity.dart';

/// Order lifecycle as written by the driver app (`OrderStatus.name`).
///
/// The customer track screen collapses these into a 4-step delivery timeline
/// via [TrackOrderStatusX.timelineStep].
enum TrackOrderStatus {
  pending,
  accepted,
  picked,
  arrived,
  delivered,
  completed,
  cancelled;

  /// Parses the raw `status` string stored on the Firebase order document.
  static TrackOrderStatus fromString(String? value) => switch ((value ?? '')
      .toLowerCase()) {
    'accepted' || 'inprogress' || 'in_progress' => TrackOrderStatus.accepted,
    'picked' || 'pickedup' || 'picked_up' => TrackOrderStatus.picked,
    'arrived' => TrackOrderStatus.arrived,
    'delivered' => TrackOrderStatus.delivered,
    'completed' => TrackOrderStatus.completed,
    'cancelled' || 'canceled' => TrackOrderStatus.cancelled,
    _ => TrackOrderStatus.pending,
  };
}

extension TrackOrderStatusX on TrackOrderStatus {
  /// True once the order has reached (been confirmed as delivered by) the customer.
  bool get isDelivered =>
      this == TrackOrderStatus.delivered || this == TrackOrderStatus.completed;

  bool get isCancelled => this == TrackOrderStatus.cancelled;

  /// The driver has arrived at the customer — the point where the customer can
  /// confirm they received the order (mark it delivered).
  bool get isArrived => this == TrackOrderStatus.arrived;

  /// A delivery is "on the move" once accepted and before it is delivered.
  bool get isActive => switch (this) {
    TrackOrderStatus.accepted ||
    TrackOrderStatus.picked ||
    TrackOrderStatus.arrived => true,
    _ => false,
  };

  /// Progress step (0..4), identical to the driver app's `OrderStatus.step`, so
  /// both apps show the exact same status progression:
  /// 0 = pending, 1 = accepted, 2 = picked, 3 = arrived, 4 = delivered.
  int get step => switch (this) {
    TrackOrderStatus.accepted => 1,
    TrackOrderStatus.picked => 2,
    TrackOrderStatus.arrived => 3,
    TrackOrderStatus.delivered || TrackOrderStatus.completed => 4,
    _ => 0,
  };
}

class TrackDriverEntity extends Equatable {
  final String id;
  final String name;
  final String phone;
  final String photo;
  final TrackLatLngEntity? location;

  const TrackDriverEntity({
    this.id = '',
    this.name = '',
    this.phone = '',
    this.photo = '',
    this.location,
  });

  bool get isEmpty => id.isEmpty && name.isEmpty && phone.isEmpty;

  @override
  List<Object?> get props => [id, name, phone, photo, location];
}

class TrackStoreEntity extends Equatable {
  final String name;
  final String address;
  final String phone;
  final TrackLatLngEntity? location;

  const TrackStoreEntity({
    this.name = '',
    this.address = '',
    this.phone = '',
    this.location,
  });

  @override
  List<Object?> get props => [name, address, phone, location];
}

class TrackCustomerEntity extends Equatable {
  final String name;
  final String address;
  final String phone;
  final TrackLatLngEntity? location;

  const TrackCustomerEntity({
    this.name = '',
    this.address = '',
    this.phone = '',
    this.location,
  });

  @override
  List<Object?> get props => [name, address, phone, location];
}

class TrackOrderItemEntity extends Equatable {
  final String name;
  final String image;
  final num price;
  final int quantity;

  const TrackOrderItemEntity({
    this.name = '',
    this.image = '',
    this.price = 0,
    this.quantity = 1,
  });

  @override
  List<Object?> get props => [name, image, price, quantity];
}

/// Everything the customer track screen needs, resolved from the Firebase
/// `orders/{orderId}` document that the driver app keeps up to date.
class TrackOrderEntity extends Equatable {
  final String id;
  final String orderNumber;
  final TrackOrderStatus status;
  final String paymentType;
  final num totalPrice;
  final TrackStoreEntity store;
  final TrackCustomerEntity customer;
  final TrackDriverEntity driver;
  final List<TrackOrderItemEntity> items;

  /// The driver's latest live position (from `driverLocation` or `driver.location`).
  final TrackLatLngEntity? driverLocation;

  /// Server timestamp of the last update, used for the "estimated arrival" line.
  final DateTime? updatedAt;

  const TrackOrderEntity({
    required this.id,
    this.orderNumber = '',
    this.status = TrackOrderStatus.pending,
    this.paymentType = '',
    this.totalPrice = 0,
    this.store = const TrackStoreEntity(),
    this.customer = const TrackCustomerEntity(),
    this.driver = const TrackDriverEntity(),
    this.items = const [],
    this.driverLocation,
    this.updatedAt,
  });

  factory TrackOrderEntity.empty(String id) => TrackOrderEntity(id: id);

  /// The store coordinate used as the route origin on the map.
  TrackLatLngEntity? get storeLocation => store.location;

  /// The customer coordinate used as the route destination on the map.
  TrackLatLngEntity? get customerLocation => customer.location;

  TrackOrderEntity copyWith({
    String? orderNumber,
    TrackOrderStatus? status,
    String? paymentType,
    num? totalPrice,
    TrackStoreEntity? store,
    TrackCustomerEntity? customer,
    TrackDriverEntity? driver,
    List<TrackOrderItemEntity>? items,
    TrackLatLngEntity? driverLocation,
    DateTime? updatedAt,
  }) {
    return TrackOrderEntity(
      id: id,
      orderNumber: orderNumber ?? this.orderNumber,
      status: status ?? this.status,
      paymentType: paymentType ?? this.paymentType,
      totalPrice: totalPrice ?? this.totalPrice,
      store: store ?? this.store,
      customer: customer ?? this.customer,
      driver: driver ?? this.driver,
      items: items ?? this.items,
      driverLocation: driverLocation ?? this.driverLocation,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
    id,
    orderNumber,
    status,
    paymentType,
    totalPrice,
    store,
    customer,
    driver,
    items,
    driverLocation,
    updatedAt,
  ];
}
