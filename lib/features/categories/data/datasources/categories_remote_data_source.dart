import 'package:injectable/injectable.dart';
import '../../api/api_client/categories_api_client.dart';
import '../models/categories_response_model.dart';
import '../models/products_response_model.dart';

abstract class CategoriesRemoteDataSource {
  Future<CategoriesResponseModel> getCategories();
  Future<ProductsResponseModel> getProducts(String? categoryId);
}

@Injectable(as: CategoriesRemoteDataSource)
class CategoriesRemoteDataSourceImpl implements CategoriesRemoteDataSource {
  final CategoriesApiClient _apiClient;

  CategoriesRemoteDataSourceImpl(this._apiClient);

  @override
  Future<CategoriesResponseModel> getCategories() => _apiClient.getCategories();

  @override
  Future<ProductsResponseModel> getProducts(String? categoryId) => _apiClient.getProducts(categoryId);
}
