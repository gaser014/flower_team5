import 'dart:developer';

import 'package:flowers_app/config/base_response/entity/base_pagination_entity.dart';
import 'package:flowers_app/config/base_response/model/base_pagination_dto.dart';
import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/features/categories/data/datasources/categories_remote_data_source_contract.dart';
import 'package:flowers_app/features/categories/data/models/category_dto.dart';
import 'package:flowers_app/features/categories/domain/entities/categories_params.dart';
import 'package:flowers_app/features/categories/domain/entities/category_entity.dart';
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
    late final Result<BasePaginationDto<CategoryDto>> result;
    switch (params.type) {
      case CategoriesType.categories:
        result = await categoriesRemoteDataSourceContract.getAllCategories(
          params: params,
        );
      case CategoriesType.occasions:
        result = await categoriesRemoteDataSourceContract.getAllOccasions(
          params: params,
        );
    }
    log('CategoriesRepositoryImpl.getAllCategories: result: $result');
    return result.makeDummyData(
      // dummyData: BasePaginationEntity.dummyData<CategoryEntity>(
      //   params: params,
      //   allData: CategoryFixtures.dummyCategories,
      // ),
      success: (data) => Success(
        data: data?.toEntity() as BasePaginationEntity<CategoryEntity>?,
      ),
      error: (exception) => Error(exception: exception),
    );
  }
}
