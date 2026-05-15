import 'package:flowers_app/config/base_response/entity/base_pagination_entity.dart';
import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/features/home/presentation/categories/domain/entities/category_entity.dart';
import 'package:flowers_app/features/home/presentation/categories/domain/entities/categories_params.dart';

abstract interface class CategoriesRepository {
  Future<Result<BasePaginationEntity<CategoryEntity>>> getAllCategories({
    required CategoriesParams params,
  });
}
