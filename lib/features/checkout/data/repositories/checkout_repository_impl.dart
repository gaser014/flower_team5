import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/features/checkout/data/data_sources/checkout_remote_data_source_contract.dart';
import 'package:flowers_app/features/checkout/domain/entities/cash_on_delivery_entity.dart';
import 'package:flowers_app/features/checkout/domain/entities/credit_card_entity.dart';
import 'package:flowers_app/features/checkout/domain/repositories/checkout_repository.dart';
import 'package:flowers_app/features/checkout/domain/use_cases/checkout_params.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CheckoutRepository)
class CheckoutRepositoryImpl implements CheckoutRepository {
  final CheckoutRemoteDataSourceContract _remoteDataSource;

  CheckoutRepositoryImpl(this._remoteDataSource);

  @override
  Future<Result<CashOnDeliveryEntity>> checkoutWithCashOnDelivery(
    CheckoutParams params,
  ) async {
    final result = await _remoteDataSource.checkoutWithCashOnDelivery(params);
    return result.when(
      success: (data) => Success(
        data: CashOnDeliveryEntity(
          error: data?.error,
          message: data?.message,
          orderNumber: data?.orderNumber,
          paymentType: data?.paymentType,
        ),
      ),
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
}
