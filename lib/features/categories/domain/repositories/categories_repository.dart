import '../../../../config/base_response/result.dart';
import '../entities/category_entity.dart';
import '../entities/product_entity.dart';

abstract class CategoriesRepository {
  Future<Result<List<CategoryEntity>>> getCategories();
  Future<Result<List<ProductEntity>>> getProducts(String? categoryId);
}
