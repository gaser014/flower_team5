import 'package:flowers_app/config/base_response/entity/base_pagination_entity.dart';
import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/config/uses_cases/use_cases.dart';
import 'package:flowers_app/features/app_filter_tabs/domain/entities/app_filter_tab_item_entity.dart';
import 'package:flowers_app/features/categories/domain/entities/category_entity.dart';
import 'package:flowers_app/features/categories/domain/entities/categories_params.dart';
import 'package:flowers_app/features/categories/domain/repositories/categories_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetAllCategoriesUseCase
    extends UseCase<BasePaginationEntity<AppFilterTabItemEntity>, CategoriesParams> {
  final CategoriesRepository repository;

  GetAllCategoriesUseCase(this.repository);

  @override
  Future<Result<BasePaginationEntity<AppFilterTabItemEntity>>> call(
    CategoriesParams parm,
  ) {
    return repository.getAllCategories(params: parm);
  }
}
