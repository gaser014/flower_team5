part of 'checkout_cubit.dart';

sealed class CheckoutEvent {
  const CheckoutEvent();
}

final class ChangePaymentMethod extends CheckoutEvent {
  final int index;
  const ChangePaymentMethod(this.index);
}

final class ToggleGift extends CheckoutEvent {
  final bool value;
  const ToggleGift(this.value);
}

final class PlaceOrderWithCash extends CheckoutEvent {
  final String street;
  final String phone;
  final String city;
  final String lat;
  final String long;

  const PlaceOrderWithCash({
    required this.street,
    required this.phone,
    required this.city,
    required this.lat,
    required this.long,
  });
}

final class PlaceOrderWithCard extends CheckoutEvent {
  final String street;
  final String phone;
  final String city;
  final String lat;
  final String long;
  final String? receiverName;
  final String? receiverPhone;

  const PlaceOrderWithCard({
    required this.street,
    required this.phone,
    required this.city,
    required this.lat,
    required this.long,
    this.receiverName,
    this.receiverPhone,
  });
}

final class PaymentCompleted extends CheckoutEvent {
  final bool success;
  const PaymentCompleted({this.success = true});
}
