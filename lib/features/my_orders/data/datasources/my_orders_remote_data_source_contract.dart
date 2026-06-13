import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/features/my_orders/data/models/orders_response_dto.dart';

abstract interface class MyOrdersRemoteDataSourceContract {
  Future<Result<OrdersResponseDto>> getMyOrders();
}
