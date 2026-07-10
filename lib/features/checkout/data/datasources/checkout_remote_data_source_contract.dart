import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/features/checkout/data/models/response/cash_on_delivery_dto.dart';
import 'package:flowers_app/features/checkout/data/models/response/credit_card_dto.dart';
import 'package:flowers_app/features/checkout/data/models/response/get_orders_dto.dart';
import 'package:flowers_app/features/checkout/domain/use_cases/checkout_params.dart';

abstract interface class CheckoutRemoteDataSourceContract {
  Future<Result<CashOnDeliveryDto>> checkoutWithCashOnDelivery(
    CheckoutParams params,
  );

  Future<Result<CreditCardDto>> checkoutWithCreditCard(CheckoutParams params);

  Future<Result<GetOrdersDto>> getMyOrders();
}
