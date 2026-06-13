import 'package:dio/dio.dart';
import 'package:flowers_app/config/api/end_points.dart';
import 'package:flowers_app/features/my_orders/data/models/orders_response_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'my_orders_api_client.g.dart';

@Injectable()
@RestApi(baseUrl: EndPoints.baseUrl)
abstract interface class MyOrdersApiClient {
  @factoryMethod
  factory MyOrdersApiClient(Dio dio) => _MyOrdersApiClient(dio);

  @GET(EndPoints.myOrders)
  Future<OrdersResponseDto> getMyOrders();
}
