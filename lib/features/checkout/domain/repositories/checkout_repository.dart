import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/features/checkout/domain/entities/cash_on_delivery_entity.dart';
import 'package:flowers_app/features/checkout/domain/entities/credit_card_entity.dart';
import 'package:flowers_app/features/checkout/domain/use_cases/checkout_params.dart';

abstract interface class CheckoutRepository {
  Future<Result<CashOnDeliveryEntity>> checkoutWithCashOnDelivery(
    CheckoutParams params,
  );

  Future<Result<CreditCardEntity>> checkoutWithCreditCard(
    CheckoutParams params,
  );
}
