import 'package:flowers_app/core/entities/product_entity.dart';

abstract interface class ProductDetailsRemoteDataSourceContract {
  Future<ProductEntity> getProductDetails(String id);
}
