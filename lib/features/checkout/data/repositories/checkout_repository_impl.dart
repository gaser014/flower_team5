import 'dart:async';
import 'dart:developer';

import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/core/data/data_sources/auth_local_data_source.dart';
import 'package:flowers_app/core/helper/jwt_utils.dart';
import 'package:flowers_app/features/checkout/data/datasources/checkout_remote_data_source_contract.dart';
import 'package:flowers_app/features/checkout/data/datasources/order_firestore_data_source_contract.dart';
import 'package:flowers_app/features/checkout/domain/entities/cash_on_delivery_entity.dart';
import 'package:flowers_app/features/checkout/domain/entities/credit_card_entity.dart';
import 'package:flowers_app/features/checkout/domain/repositories/checkout_repository.dart';
import 'package:flowers_app/features/checkout/domain/use_cases/checkout_params.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CheckoutRepository)
class CheckoutRepositoryImpl implements CheckoutRepository {
  final CheckoutRemoteDataSourceContract _remoteDataSource;
  final OrderFirestoreDataSourceContract _orderFirestoreDataSource;
  final AuthLocalDataSourceContract _authLocalDataSource;

  CheckoutRepositoryImpl(
    this._remoteDataSource,
    this._orderFirestoreDataSource,
    this._authLocalDataSource,
  );

  @override
  Future<Result<CashOnDeliveryEntity>> checkoutWithCashOnDelivery(
    CheckoutParams params,
  ) async {
    final result = await _remoteDataSource.checkoutWithCashOnDelivery(params);
    return result.when(
      success: (data) {
        final order = data?.order;
        if (order != null) {
          unawaited(_mirrorOrderToFirestore(order, params));
        }
        return Success(
          data: CashOnDeliveryEntity(
            error: data?.error,
            message: data?.message,
            orderNumber: data?.orderNumber,
            paymentType: data?.paymentType,
          ),
        );
      },
      error: (exception) => Error(exception: exception),
    );
  }

  @override
  Future<Result<CreditCardEntity>> checkoutWithCreditCard(
    CheckoutParams params,
  ) async {
    final result = await _remoteDataSource.checkoutWithCreditCard(params);
    return result.when(
      success: (data) => Success(
        data: CreditCardEntity(
          error: data?.error,
          message: data?.message,
          url: data?.url,
          successUrl: data?.successUrl,
        ),
      ),
      error: (exception) => Error(exception: exception),
    );
  }

  @override
  Future<void> syncCardOrder(CheckoutParams params) async {
    try {
      final result = await _remoteDataSource.getMyOrders();
      final latest = result.when(
        success: (data) => data?.latest,
        error: (_) => null,
      );
      if (latest == null) return;
      await _mirrorOrderToFirestore(latest, params);
    } catch (error, stackTrace) {
      log('Failed to sync card order', error: error, stackTrace: stackTrace);
    }
  }

  Future<void> _mirrorOrderToFirestore(
    Map<String, dynamic> order,
    CheckoutParams params,
  ) async {
    try {
      final token = await _authLocalDataSource.getUserToken();
      await _orderFirestoreDataSource.createOrder(
        order: order,
        params: params,
        userId: _claim(token, const ['id', 'userId', '_id', 'sub']),
        userName: _claim(token, const ['name', 'userName']),
      );
    } catch (error, stackTrace) {
      log(
        'Failed to mirror order to Firestore',
        error: error,
        stackTrace: stackTrace,
      );
    }
  }

  String? _claim(String? token, List<String> keys) {
    if (token == null || token.isEmpty) return null;
    for (final key in keys) {
      final value = JwtUtils.getClaim<dynamic>(token, key);
      if (value != null && value.toString().isNotEmpty) {
        return value.toString();
      }
    }
    return null;
  }
}
