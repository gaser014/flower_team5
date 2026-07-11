import 'package:flowers_app/config/api/api_execute.dart';
import 'package:flowers_app/config/base_response/result.dart';
import '../api_client/categories_api_client.dart';
import '../../data/datasources/categories_remote_data_source_contract.dart';
import '../../data/models/categories_response_dto.dart';
import '../../data/models/occasions_response_dto.dart';
import '../../domain/entities/categories_params.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: CategoriesRemoteDataSourceContract)
class CategoriesRemoteDataSourceImpl
    implements CategoriesRemoteDataSourceContract {
  final CategoriesApiClient apiClient;

  CategoriesRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<Result<CategoriesResponseDto>> getAllCategories({
    required CategoriesParams params,
  }) async {
    return await executeApi<CategoriesResponseDto>(
      () => apiClient.getAllCategories(params),
    );
  }

  @override
  Future<Result<OccasionsResponseDto>> getAllOccasions({
    required CategoriesParams params,
  }) async {
    return await executeApi<OccasionsResponseDto>(
      () => apiClient.getAllOccasions(params),
    );
  }
}
