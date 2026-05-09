import 'package:flowers_app/config/api/api_execute.dart';
import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/features/products/data/datasources/products_remote_data_source_contract.dart';
import 'package:flowers_app/features/products/data/models/products_response_dto.dart';
import 'package:flowers_app/features/products/domain/entities/products_params.dart';
import 'package:flowers_app/features/products/api/api_client/products_api_client.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ProductsRemoteDataSourceContract)
class ProductsRemoteDataSourceImpl implements ProductsRemoteDataSourceContract {
  final ProductsApiClient apiClient;

  ProductsRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<Result<ProductsResponseDto>> getAllProducts({
    required ProductsParams params,
  }) async {
    return await executeApi<ProductsResponseDto>(
      () => apiClient.getAllProducts(params),
    );
  }
}
