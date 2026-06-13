import 'package:equatable/equatable.dart';

class OrderEntity extends Equatable {
  final String? id;
  final String? user;
  final List<dynamic>? orderItems;
  final num? totalPrice;
  final String? paymentType;
  final bool? isPaid;
  final bool? isDelivered;
  final String? state;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? orderNumber;

  const OrderEntity({
    this.id,
    this.user,
    this.orderItems,
    this.totalPrice,
    this.paymentType,
    this.isPaid,
    this.isDelivered,
    this.state,
    this.createdAt,
    this.updatedAt,
    this.orderNumber,
  });

  @override
  List<Object?> get props => [
        id,
        user,
        orderItems,
        totalPrice,
        paymentType,
        isPaid,
        isDelivered,
        state,
        createdAt,
        updatedAt,
        orderNumber,
      ];
}
