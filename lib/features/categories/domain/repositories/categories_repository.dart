import 'package:flowers_app/config/base_response/entity/base_pagination_entity.dart';
import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/features/app_filter_tabs/domain/entities/app_filter_tab_item_entity.dart';
import 'package:flowers_app/features/categories/domain/entities/category_entity.dart';
import 'package:flowers_app/features/categories/domain/entities/categories_params.dart';

abstract interface class CategoriesRepository {
  Future<Result<BasePaginationEntity<AppFilterTabItemEntity>>> getAllCategories({
    required CategoriesParams params,
  });
}
