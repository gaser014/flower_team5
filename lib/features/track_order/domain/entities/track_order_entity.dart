import 'package:equatable/equatable.dart';
import 'package:flowers_app/features/track_order/domain/entities/track_order_item_entity.dart';
import 'package:flowers_app/features/track_order/domain/entities/track_order_status.dart';

class TrackOrderEntity extends Equatable {
  final String id;
  final String orderNumber;
  final TrackOrderStatus status;
  final String addressLabel;
  final String addressDetails;
  final String paymentLabel;
  final List<TrackOrderItemEntity> items;
  final num subTotal;
  final num deliveryFee;
  final num total;
  final double? driverLat;
  final double? driverLng;

  const TrackOrderEntity({
    required this.id,
    required this.orderNumber,
    required this.status,
    required this.addressLabel,
    required this.addressDetails,
    required this.paymentLabel,
    required this.items,
    required this.subTotal,
    required this.deliveryFee,
    required this.total,
    this.driverLat,
    this.driverLng,
  });

  bool get hasDriverLocation => driverLat != null && driverLng != null;

  @override
  List<Object?> get props => [
    id,
    orderNumber,
    status,
    addressLabel,
    addressDetails,
    paymentLabel,
    items,
    subTotal,
    deliveryFee,
    total,
    driverLat,
    driverLng,
  ];
}
