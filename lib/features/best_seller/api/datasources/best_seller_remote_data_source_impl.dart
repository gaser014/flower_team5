import 'package:flowers_app/config/base_response/entity/base_pagination_entity.dart';
import 'package:flowers_app/features/best_seller/api/api_client/best_seller_api_client.dart';
import 'package:flowers_app/features/best_seller/data/datasources/best_seller_remote_data_source_contract.dart';
import 'package:flowers_app/features/products/domain/entities/product_entity.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: BestSellerRemoteDataSourceContract)
class BestSellerRemoteDataSourceImpl implements BestSellerRemoteDataSourceContract {
  final BestSellerApiClient _apiClient;

  BestSellerRemoteDataSourceImpl(this._apiClient);

  @override
  Future<BasePaginationEntity<ProductEntity>> getBestSellers({
    int? page,
    int? limit,
  }) async {
    final response = await _apiClient.getBestSellers(page: page, limit: limit);
    return response.toEntity();
  }
}
