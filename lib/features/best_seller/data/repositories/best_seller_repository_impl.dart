import 'package:flowers_app/config/base_response/entity/base_pagination_entity.dart';
import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/features/best_seller/data/datasources/best_seller_remote_data_source_contract.dart';
import 'package:flowers_app/core/entities/product_entity.dart';
import 'package:flowers_app/features/best_seller/domain/repositories/best_seller_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: BestSellerRepository)
class BestSellerRepositoryImpl implements BestSellerRepository {
  final BestSellerRemoteDataSourceContract _remoteDataSource;

  BestSellerRepositoryImpl(this._remoteDataSource);

  @override
  Future<Result<BasePaginationEntity<ProductEntity>>> getBestSellers({
    int? page,
    int? limit,
  }) async {
    try {
      final result = await _remoteDataSource.getBestSellers(
        page: page,
        limit: limit,
      );
      return Result.success(result);
    } on Exception catch (e) {
      return Result.failure(e);
    }
  }
}
