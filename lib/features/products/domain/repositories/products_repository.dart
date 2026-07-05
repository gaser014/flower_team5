import 'package:flowers_app/config/base_response/entity/base_pagination_entity.dart';
import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/features/products/domain/entities/product_entity.dart';
import 'package:flowers_app/features/products/domain/entities/products_params.dart';

abstract interface class ProductsRepository {
  Future<Result<BasePaginationEntity<ProductEntity>>> getAllProducts({
    required ProductsParams params,
  });
}
