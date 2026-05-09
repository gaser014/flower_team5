import 'package:flowers_app/config/base_response/entity/base_pagination_entity.dart';
import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/features/categories/data/datasources/categories_remote_data_source_contract.dart';
import 'package:flowers_app/features/categories/data/fixtures/category_fixtures.dart';
import 'package:flowers_app/features/categories/domain/entities/category_entity.dart';
import 'package:flowers_app/features/categories/domain/entities/categories_params.dart';
import 'package:flowers_app/features/categories/domain/repositories/categories_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: CategoriesRepository)
class CategoriesRepositoryImpl implements CategoriesRepository {
  final CategoriesRemoteDataSourceContract categoriesRemoteDataSourceContract;

  CategoriesRepositoryImpl({required this.categoriesRemoteDataSourceContract});

  @override
  Future<Result<BasePaginationEntity<CategoryEntity>>> getAllCategories({
    required CategoriesParams params,
  }) async {
    final result = await categoriesRemoteDataSourceContract.getAllCategories(
      params: params,
    );
    return result.makeDummyData(
      // dummyData: BasePaginationEntity.dummyData<CategoryEntity>(
      //   params: params,
      //   allData: CategoryFixtures.dummyCategories,
      // ),
      success: (data) => Success(data: data?.toEntity()),
      error: (exception) => Error(exception: exception),
    );
  }
}
