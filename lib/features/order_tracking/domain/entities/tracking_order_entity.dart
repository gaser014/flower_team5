import 'package:equatable/equatable.dart';
import 'package:flowers_app/features/order_tracking/domain/entities/lat_lng_entity.dart';

class TrackingOrderEntity extends Equatable {
  final String orderId;
  final String orderNumber;
  final String status;
  final LatLngEntity? storeLocation;
  final LatLngEntity? userLocation;
  final LatLngEntity? driverLocation;
  final String storeName;
  final String customerName;
  final String customerAddress;
  final String driverName;
  final String driverPhone;
  final String driverPhoto;
  final DateTime? estimatedArrival;

  const TrackingOrderEntity({
    this.orderId = '',
    this.orderNumber = '',
    this.status = '',
    this.storeLocation,
    this.userLocation,
    this.driverLocation,
    this.storeName = '',
    this.customerName = '',
    this.customerAddress = '',
    this.driverName = '',
    this.driverPhone = '',
    this.driverPhoto = '',
    this.estimatedArrival,
  });

  bool get hasDriver => driverName.isNotEmpty || driverLocation != null;

  @override
  List<Object?> get props => [
    orderId,
    orderNumber,
    status,
    storeLocation,
    userLocation,
    driverLocation,
    storeName,
    customerName,
    customerAddress,
    driverName,
    driverPhone,
    driverPhoto,
    estimatedArrival,
  ];
}
