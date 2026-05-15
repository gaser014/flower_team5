import 'package:flowers_app/core/entities/product_entity.dart';
import 'package:flowers_app/config/base_response/result.dart';

abstract interface class ProductDetailsRepository {
  Future<Result<ProductEntity>> getProductDetails(String id);
}
