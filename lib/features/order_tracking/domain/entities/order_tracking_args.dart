import 'package:equatable/equatable.dart';

class OrderTrackingArgs extends Equatable {
  final String orderId;
  final String orderNumber;

  const OrderTrackingArgs({this.orderId = '', this.orderNumber = ''});

  bool get isEmpty => orderId.isEmpty && orderNumber.isEmpty;

  @override
  List<Object?> get props => [orderId, orderNumber];
}
