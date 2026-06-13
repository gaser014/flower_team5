import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/features/my_orders/data/datasources/my_orders_remote_data_source_contract.dart';
import 'package:flowers_app/features/my_orders/domain/entities/order_entity.dart';
import 'package:flowers_app/features/my_orders/domain/repositories/my_orders_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: MyOrdersRepository)
class MyOrdersRepositoryImpl implements MyOrdersRepository {
  final MyOrdersRemoteDataSourceContract _remoteDataSource;

  MyOrdersRepositoryImpl(this._remoteDataSource);

  @override
  Future<Result<List<OrderEntity>>> getMyOrders() async {
    final result = await _remoteDataSource.getMyOrders();

    return result.when(
      success: (data) {
        final ordersList = data?.orders?.map((e) => e.toEntity()).toList() ?? [];
        return Success<List<OrderEntity>>(data: ordersList);
      },
      error: (error) {
        return Error(exception: error);
      },
    );
  }
}
