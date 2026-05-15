import 'package:flowers_app/features/products/domain/entities/product_entity.dart';

abstract interface class ProductDetailsRemoteDataSourceContract {
  Future<ProductEntity> getProductDetails(String id);
}
