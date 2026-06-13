part of 'checkout_cubit.dart';

class CheckoutState extends Equatable {
  final BaseState<CreditCardEntity?> checkoutState;
  final int selectedPayment;
  final bool isGift;
  final String? paymentUrl;
  final String? successUrl;
  final String street;
  final String phone;
  final String city;
  final List<AddressEntity> addresses;

  const CheckoutState({
    this.checkoutState = const BaseState<CreditCardEntity?>.initial(),
    this.selectedPayment = 0,
    this.isGift = false,
    this.paymentUrl,
    this.successUrl,
    this.street = '',
    this.phone = '',
    this.city = '',
    this.addresses = const [],
  });

  CheckoutState copyWith({
    BaseState<CreditCardEntity?>? checkoutState,
    int? selectedPayment,
    bool? isGift,
    String? paymentUrl,
    String? successUrl,
    String? street,
    String? phone,
    String? city,
    List<AddressEntity>? addresses,
    bool clearError = false,
  }) {
    return CheckoutState(
      checkoutState: checkoutState ?? this.checkoutState,
      selectedPayment: selectedPayment ?? this.selectedPayment,
      isGift: isGift ?? this.isGift,
      paymentUrl: clearError ? null : (paymentUrl ?? this.paymentUrl),
      successUrl: clearError ? null : (successUrl ?? this.successUrl),
      street: street ?? this.street,
      phone: phone ?? this.phone,
      city: city ?? this.city,
      addresses: addresses ?? this.addresses,
    );
  }

  @override
  List<Object?> get props => [
    checkoutState,
    selectedPayment,
    isGift,
    paymentUrl,
    successUrl,
    street,
    phone,
    city,
    addresses,
  ];
}
