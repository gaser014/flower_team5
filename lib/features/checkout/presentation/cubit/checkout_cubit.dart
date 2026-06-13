import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flowers_app/config/base_state/base_state.dart';
import 'package:flowers_app/config/uses_cases/use_cases.dart';
import 'package:flowers_app/features/addresses/domain/entities/address_entity.dart';
import 'package:flowers_app/features/addresses/domain/use_cases/get_addresses.dart';
import 'package:flowers_app/features/checkout/domain/entities/credit_card_entity.dart';
import 'package:flowers_app/features/checkout/domain/use_cases/checkout_params.dart';
import 'package:flowers_app/features/checkout/domain/use_cases/checkout_with_cash_usecase.dart';
import 'package:flowers_app/features/checkout/domain/use_cases/checkout_with_card_usecase.dart';
import 'package:injectable/injectable.dart';

part 'checkout_event.dart';
part 'checkout_state.dart';

@injectable
class CheckoutCubit extends Cubit<CheckoutState> {
  final CheckoutWithCashUseCase _checkoutWithCashUseCase;
  final CheckoutWithCardUseCase _checkoutWithCardUseCase;
  final GetAddressesUseCase _getAddressesUseCase;

  CheckoutCubit(
    this._checkoutWithCashUseCase,
    this._checkoutWithCardUseCase,
    this._getAddressesUseCase,
  ) : super(const CheckoutState());

  @override
  void emit(CheckoutState state) {
    if (!isClosed) super.emit(state);
  }

  Future<void> doEvent(CheckoutEvent event) async {
    switch (event) {
      case LoadAddresses():
        await _loadAddresses();
      case ChangePaymentMethod():
        emit(state.copyWith(
          selectedPayment: event.index,
          clearError: true,
          paymentUrl: null,
        ));
      case ToggleGift():
        emit(state.copyWith(isGift: event.value, clearError: true));
      case PlaceOrderWithCash():
        await _placeOrderWithCash(event);
      case PlaceOrderWithCard():
        await _placeOrderWithCard(event);
      case PaymentCompleted():
        if (event.success) {
          emit(state.copyWith(
            checkoutState: const BaseState<CreditCardEntity?>.success(null),
            paymentUrl: null,
          ));
        } else {
          emit(state.copyWith(
            checkoutState: BaseState<CreditCardEntity?>.error(
              Exception('Payment failed'),
            ),
          ));
        }
    }
  }

  Future<void> _placeOrderWithCash(PlaceOrderWithCash event) async {
    emit(state.copyWith(
      checkoutState: const BaseState<CreditCardEntity?>.loading(),
    ));

    final params = CheckoutParams(
      street: event.street,
      phone: event.phone,
      city: event.city,
      lat: event.lat,
      long: event.long,
    );

    final result = await _checkoutWithCashUseCase.call(params);

    result.when(
      success: (_) {
        emit(state.copyWith(
          checkoutState: const BaseState<CreditCardEntity?>.success(null),
          paymentUrl: null,
        ));
      },
      error: (exception) {
        emit(state.copyWith(
          checkoutState: BaseState<CreditCardEntity?>.error(
            exception ?? Exception('Checkout failed'),
          ),
        ));
      },
    );
  }

  Future<void> _placeOrderWithCard(PlaceOrderWithCard event) async {
    emit(state.copyWith(
      checkoutState: const BaseState<CreditCardEntity?>.loading(),
    ));

    final params = CheckoutParams(
      street: event.street,
      phone: event.phone,
      city: event.city,
      lat: event.lat,
      long: event.long,
    );

    final result = await _checkoutWithCardUseCase.call(params);

    result.when(
      success: (data) {
        emit(state.copyWith(
          checkoutState: BaseState<CreditCardEntity?>.success(data),
          paymentUrl: data?.url,
          successUrl: data?.successUrl,
        ));
      },
      error: (exception) {
        emit(state.copyWith(
          checkoutState: BaseState<CreditCardEntity?>.error(
            exception ?? Exception('Card checkout failed'),
          ),
        ));
      },
    );
  }

  Future<void> _loadAddresses() async {
    final result = await _getAddressesUseCase.call(const NoParams());
    result.when(
      success: (data) {
        emit(state.copyWith(addresses: data));
      },
      error: (_) {},
    );
  }
}
