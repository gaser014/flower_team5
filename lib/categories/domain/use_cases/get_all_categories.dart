import 'package:flowers_app/config/base_response/entity/base_pagination_entity.dart';
import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/config/uses_cases/use_cases.dart';
import '../entities/category_entity.dart';
import '../entities/categories_params.dart';
import '../repositories/categories_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class GetAllCategoriesUseCase
    extends UseCase<BasePaginationEntity<CategoryEntity>, CategoriesParams> {
  final CategoriesRepository repository;

  GetAllCategoriesUseCase(this.repository);

  @override
  Future<Result<BasePaginationEntity<CategoryEntity>>> call(
    CategoriesParams parm,
  ) {
    return repository.getAllCategories(params: parm);
  }
}
