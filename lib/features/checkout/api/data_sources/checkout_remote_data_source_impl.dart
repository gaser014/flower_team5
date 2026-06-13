import 'package:flowers_app/config/api/api_execute.dart';
import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/features/checkout/api/api_client/checkout_api_client.dart';
import 'package:flowers_app/features/checkout/data/data_sources/checkout_remote_data_source_contract.dart';
import 'package:flowers_app/features/checkout/data/models/request/checkout_request_dto.dart';
import 'package:flowers_app/features/checkout/data/models/response/cash_on_delivery_dto.dart';
import 'package:flowers_app/features/checkout/data/models/response/credit_card_dto.dart';
import 'package:flowers_app/features/checkout/domain/use_cases/checkout_params.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CheckoutRemoteDataSourceContract)
class CheckoutRemoteDataSourceImpl implements CheckoutRemoteDataSourceContract {
  final CheckoutApiClient _apiClient;

  CheckoutRemoteDataSourceImpl(this._apiClient);

  @override
  Future<Result<CashOnDeliveryDto>> checkoutWithCashOnDelivery(
    CheckoutParams params,
  ) async {
    return executeApi(() => _apiClient.checkoutWithCashOnDelivery(
          CheckoutRequestDto(
            shippingAddress: ShippingAddressDto(
              street: params.street,
              phone: params.phone,
              city: params.city,
              lat: params.lat,
              long: params.long,
            ),
          ),
        ));
  }

  @override
  Future<Result<CreditCardDto>> checkoutWithCreditCard(
    CheckoutParams params,
  ) async {
    return executeApi(() => _apiClient.checkoutWithCreditCard(
          CheckoutRequestDto(
            shippingAddress: ShippingAddressDto(
              street: params.street,
              phone: params.phone,
              city: params.city,
              lat: params.lat,
              long: params.long,
            ),
          ),
        ));
  }
}
