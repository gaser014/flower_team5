import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/features/my_orders/domain/entities/order_entity.dart';

abstract interface class MyOrdersRepository {
  Future<Result<List<OrderEntity>>> getMyOrders();
}
