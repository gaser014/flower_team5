import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/features/my_orders/api/api_client/my_orders_api_client.dart';
import 'package:flowers_app/features/my_orders/data/datasources/my_orders_remote_data_source_contract.dart';
import 'package:flowers_app/features/my_orders/data/models/orders_response_dto.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: MyOrdersRemoteDataSourceContract)
class MyOrdersRemoteDataSourceImpl implements MyOrdersRemoteDataSourceContract {
  final MyOrdersApiClient _apiClient;

  MyOrdersRemoteDataSourceImpl(this._apiClient);

  @override
  Future<Result<OrdersResponseDto>> getMyOrders() async {
    try {
      final response = await _apiClient.getMyOrders();
      return Success(data: response);
    } catch (e) {
      return Error(exception: e as Exception);
    }
  }
}
