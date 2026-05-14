import 'package:flowers_app/config/api/api_execute.dart';
import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/features/home/api/api_client/home_api_client.dart';
import 'package:flowers_app/features/home/data/datasources/home_remote_data_source_contract.dart';
import 'package:flowers_app/features/home/data/models/home_dto.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: HomeRemoteDataSourceContract)
class HomeRemoteDataSourceImpl implements HomeRemoteDataSourceContract {
  final HomeApiClient _apiClient;

  HomeRemoteDataSourceImpl(this._apiClient);

  @override
  Future<Result<HomeDto>> getHomeData() async {
    return await executeApi(() async {
      final response = await _apiClient.getHomeData();
      return response;
    });
  }
}
