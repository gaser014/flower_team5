abstract class PaymentState {}

class PaymentInitial extends PaymentState {}

class PaymentLoading extends PaymentState {}

class PaymentCheckoutSuccess extends PaymentState {
  final String url;
  PaymentCheckoutSuccess(this.url);
}

class PaymentCashSuccess extends PaymentState {}

class PaymentError extends PaymentState {
  final String error;
  PaymentError(this.error);
}
