import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

  CheckoutCubit(
    this._checkoutWithCashUseCase,
    this._checkoutWithCardUseCase,
  ) : super(const CheckoutState());

  @override
  void emit(CheckoutState state) {
    if (!isClosed) super.emit(state);
  }

  Future<void> doEvent(CheckoutEvent event) async {
    switch (event) {
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
            status: CheckoutStatus.success,
            paymentUrl: null,
          ));
        } else {
          emit(state.copyWith(
            status: CheckoutStatus.error,
            errorMessage: null,
          ));
        }
    }
  }

  Future<void> _placeOrderWithCash(PlaceOrderWithCash event) async {
    emit(state.copyWith(status: CheckoutStatus.loading));

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
          status: CheckoutStatus.success,
          paymentUrl: null,
        ));
      },
      error: (exception) {
        emit(state.copyWith(
          status: CheckoutStatus.error,
          errorMessage: exception?.toString(),
        ));
      },
    );
  }

  Future<void> _placeOrderWithCard(PlaceOrderWithCard event) async {
    emit(state.copyWith(status: CheckoutStatus.loading));

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
          status: CheckoutStatus.paymentPending,
          paymentUrl: data?.url,
          successUrl: data?.successUrl,
        ));
      },
      error: (exception) {
        emit(state.copyWith(
          status: CheckoutStatus.error,
          errorMessage: exception?.toString(),
        ));
      },
    );
  }
}
