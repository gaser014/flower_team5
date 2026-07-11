part of 'checkout_cubit.dart';

class CheckoutStates extends Equatable {
  final BaseState<CheckoutResultEntity> orderState;
  final int selectedPayment;
  final bool isGift;
  final List<CheckoutAddressEntity> addresses;
  final int selectedAddressIndex;

  const CheckoutStates({
    this.orderState = const BaseState.initial(),
    this.selectedPayment = 0,
    this.isGift = false,
    this.addresses = const [],
    this.selectedAddressIndex = 0,
  });

  CheckoutAddressEntity? get selectedAddress =>
      (selectedAddressIndex >= 0 && selectedAddressIndex < addresses.length)
      ? addresses[selectedAddressIndex]
      : null;

  CheckoutStates copyWith({
    BaseState<CheckoutResultEntity>? orderState,
    int? selectedPayment,
    bool? isGift,
    List<CheckoutAddressEntity>? addresses,
    int? selectedAddressIndex,
  }) {
    return CheckoutStates(
      orderState: orderState ?? this.orderState,
      selectedPayment: selectedPayment ?? this.selectedPayment,
      isGift: isGift ?? this.isGift,
      addresses: addresses ?? this.addresses,
      selectedAddressIndex: selectedAddressIndex ?? this.selectedAddressIndex,
    );
  }

  @override
  List<Object?> get props => [
    orderState,
    selectedPayment,
    isGift,
    addresses,
    selectedAddressIndex,
  ];
}
