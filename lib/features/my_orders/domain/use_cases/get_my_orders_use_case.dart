import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/features/my_orders/domain/entities/order_entity.dart';
import 'package:flowers_app/features/my_orders/domain/repositories/my_orders_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetMyOrdersUseCase {
  final MyOrdersRepository repository;

  GetMyOrdersUseCase(this.repository);

  Future<Result<List<OrderEntity>>> call() {
    return repository.getMyOrders();
  }
}
