part of 'checkout_cubit.dart';

sealed class CheckoutEvents {
  const CheckoutEvents();
}

final class ChangePaymentMethodEvent extends CheckoutEvents {
  final int index;
  const ChangePaymentMethodEvent(this.index);
}

final class SelectAddressEvent extends CheckoutEvents {
  final int index;
  const SelectAddressEvent(this.index);
}

final class ToggleGiftEvent extends CheckoutEvents {
  final bool value;
  const ToggleGiftEvent(this.value);
}

final class PlaceOrderWithCashEvent extends CheckoutEvents {
  const PlaceOrderWithCashEvent();
}

final class PlaceOrderWithCardEvent extends CheckoutEvents {
  final String? receiverName;
  final String? receiverPhone;

  const PlaceOrderWithCardEvent({this.receiverName, this.receiverPhone});
}

final class PaymentCompletedEvent extends CheckoutEvents {
  final bool success;
  const PaymentCompletedEvent({this.success = true});
}
