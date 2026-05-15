import 'package:flowers_app/config/base_response/entity/base_pagination_entity.dart';
import 'package:flowers_app/config/uses_cases/pagination_params.dart';
import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/features/products/domain/entities/product_entity.dart';
import 'package:flowers_app/features/best_seller/domain/repositories/best_seller_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetBestSellersUseCase {
  final BestSellerRepository _repository;

  GetBestSellersUseCase(this._repository);

  Future<Result<BasePaginationEntity<ProductEntity>>> execute(
    PaginationParams params,
  ) {
    return _repository.getBestSellers(page: params.page, limit: params.limit);
  }
}
