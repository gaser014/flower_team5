import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flowers_app/config/base_state/base_state.dart';
import 'package:flowers_app/core/values/app_strings.dart';
import 'package:flowers_app/features/checkout/data/fixtures/checkout_address_fixtures.dart';
import 'package:flowers_app/features/checkout/domain/entities/checkout_address_entity.dart';
import 'package:flowers_app/features/checkout/domain/entities/checkout_result_entity.dart';
import 'package:flowers_app/features/checkout/domain/use_cases/checkout_params.dart';
import 'package:flowers_app/features/checkout/domain/use_cases/checkout_with_card_usecase.dart';
import 'package:flowers_app/features/checkout/domain/use_cases/checkout_with_cash_usecase.dart';
import 'package:flowers_app/features/checkout/domain/use_cases/sync_card_order_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'checkout_events.dart';
part 'checkout_states.dart';

@injectable
class CheckoutCubit extends Cubit<CheckoutStates> {
  final CheckoutWithCashUseCase _checkoutWithCashUseCase;
  final CheckoutWithCardUseCase _checkoutWithCardUseCase;
  final SyncCardOrderUseCase _syncCardOrderUseCase;

  CheckoutCubit(
    this._checkoutWithCashUseCase,
    this._checkoutWithCardUseCase,
    this._syncCardOrderUseCase,
  ) : super(const CheckoutStates());

  @override
  void emit(CheckoutStates state) {
    if (!isClosed) super.emit(state);
  }

  Future<void> doIntent(CheckoutEvents event) async {
    switch (event) {
      case ChangePaymentMethodEvent():
        _changePaymentMethod(event);
      case SelectAddressEvent():
        _selectAddress(event);
      case ToggleGiftEvent():
        _toggleGift(event);
      case PlaceOrderWithCashEvent():
        await _placeOrderWithCash(event);
      case PlaceOrderWithCardEvent():
        await _placeOrderWithCard(event);
      case PaymentCompletedEvent():
        await _onPaymentCompleted(event);
    }
  }

  void _changePaymentMethod(ChangePaymentMethodEvent event) {
    emit(
      state.copyWith(
        selectedPayment: event.index,
        orderState: const BaseState.initial(),
      ),
    );
  }

  void _selectAddress(SelectAddressEvent event) {
    emit(state.copyWith(selectedAddressIndex: event.index));
  }

  void _toggleGift(ToggleGiftEvent event) {
    emit(state.copyWith(isGift: event.value));
  }

  /// Builds the checkout params from the currently selected address so the
  /// request carries real coordinates (no more `withoutLocation` fallback).
  CheckoutParams? _buildParams() {
    final address = state.selectedAddress;
    if (address == null) return null;
    return CheckoutParams(
      street: address.street,
      phone: address.phone,
      city: address.city,
      lat: address.lat,
      long: address.long,
    );
  }

  Future<void> _placeOrderWithCash(PlaceOrderWithCashEvent event) async {
    if (state.orderState.isLoading) return;

    final params = _buildParams();
    if (params == null) {
      emit(
        state.copyWith(
          orderState: BaseState.error(Exception(AppStrings.selectAddressError)),
        ),
      );
      return;
    }

    emit(state.copyWith(orderState: const BaseState.loading()));

    final result = await _checkoutWithCashUseCase.call(params);

    result.when(
      success: (data) => emit(
        state.copyWith(
          orderState: BaseState.success(
            CheckoutResultEntity(
              requiresPayment: false,
              orderNumber: data?.orderNumber,
              message: data?.message,
            ),
          ),
        ),
      ),
      error: (exception) => emit(
        state.copyWith(
          orderState: BaseState.error(
            exception ?? Exception(AppStrings.somethingWentWrong),
          ),
        ),
      ),
    );
  }

  Future<void> _placeOrderWithCard(PlaceOrderWithCardEvent event) async {
    if (state.orderState.isLoading) return;

    final params = _buildParams();
    if (params == null) {
      emit(
        state.copyWith(
          orderState: BaseState.error(Exception(AppStrings.selectAddressError)),
        ),
      );
      return;
    }

    emit(state.copyWith(orderState: const BaseState.loading()));

    final result = await _checkoutWithCardUseCase.call(params);

    result.when(
      success: (data) => emit(
        state.copyWith(
          orderState: BaseState.success(
            CheckoutResultEntity(
              requiresPayment: true,
              paymentUrl: data?.url,
              successUrl: data?.successUrl,
              message: data?.message,
            ),
          ),
        ),
      ),
      error: (exception) => emit(
        state.copyWith(
          orderState: BaseState.error(
            exception ?? Exception(AppStrings.somethingWentWrong),
          ),
        ),
      ),
    );
  }

  Future<void> _onPaymentCompleted(PaymentCompletedEvent event) async {
    if (!event.success) {
      emit(
        state.copyWith(
          orderState: BaseState.error(Exception(AppStrings.somethingWentWrong)),
        ),
      );
      return;
    }

    final params = _buildParams();
    if (params != null) {
      unawaited(_syncCardOrderUseCase.call(params));
    }
    emit(
      state.copyWith(
        orderState: const BaseState.success(
          CheckoutResultEntity(requiresPayment: false),
        ),
      ),
    );
  }
}
