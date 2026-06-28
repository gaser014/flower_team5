import 'package:equatable/equatable.dart';

class CheckoutResultEntity extends Equatable {
  final bool requiresPayment;
  final String? paymentUrl;
  final String? successUrl;
  final String? orderNumber;
  final String? message;

  const CheckoutResultEntity({
    this.requiresPayment = false,
    this.paymentUrl,
    this.successUrl,
    this.orderNumber,
    this.message,
  });

  @override
  List<Object?> get props => [
    requiresPayment,
    paymentUrl,
    successUrl,
    orderNumber,
    message,
  ];
}
