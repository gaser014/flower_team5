import 'package:flowers_app/features/product_details/api/api_client/product_details_api_client.dart';
import 'package:flowers_app/features/product_details/data/datasources/product_details_remote_data_source_contract.dart';
import 'package:flowers_app/features/products/domain/entities/product_entity.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProductDetailsRemoteDataSourceContract)
class ProductDetailsRemoteDataSourceImpl
    implements ProductDetailsRemoteDataSourceContract {
  final ProductDetailsApiClient _apiClient;

  ProductDetailsRemoteDataSourceImpl(this._apiClient);

  @override
  Future<ProductEntity> getProductDetails(String id) async {
    final response = await _apiClient.getProductDetails(id);
    return response.toEntity();
  }
}
