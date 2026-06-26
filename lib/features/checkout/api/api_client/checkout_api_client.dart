import 'package:dio/dio.dart';
import 'package:flowers_app/config/api/end_points.dart';
import 'package:flowers_app/features/checkout/data/models/request/checkout_request_dto.dart';
import 'package:flowers_app/features/checkout/data/models/response/cash_on_delivery_dto.dart';
import 'package:flowers_app/features/checkout/data/models/response/credit_card_dto.dart';
import 'package:flowers_app/features/checkout/data/models/response/get_orders_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'checkout_api_client.g.dart';

@Injectable()
@RestApi()
abstract class CheckoutApiClient {
  @factoryMethod
  factory CheckoutApiClient(Dio dio) = _CheckoutApiClient;

  @POST(EndPoints.cashCheckOut)
  Future<CashOnDeliveryDto> checkoutWithCashOnDelivery(
    @Body() CheckoutRequestDto request,
  );

  @POST(EndPoints.creditCheckOut)
  Future<CreditCardDto> checkoutWithCreditCard(
    @Body() CheckoutRequestDto request,
  );

  @GET(EndPoints.ordersPage)
  Future<GetOrdersDto> getMyOrders();
}
