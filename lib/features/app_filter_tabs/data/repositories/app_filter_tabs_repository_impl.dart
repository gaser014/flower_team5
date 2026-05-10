import 'dart:developer';

import 'package:flowers_app/config/base_response/entity/base_pagination_entity.dart';
import 'package:flowers_app/config/base_response/model/base_pagination_dto.dart';
import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/features/app_filter_tabs/data/datasources/app_filter_tabs_remote_data_source_contract.dart';
import 'package:flowers_app/features/app_filter_tabs/data/models/app_filter_tab_item_dto.dart';
import 'package:flowers_app/features/app_filter_tabs/domain/entities/app_filter_tabs_params.dart';
import 'package:flowers_app/features/app_filter_tabs/domain/entities/app_filter_tab_item_entity.dart';
import 'package:flowers_app/features/app_filter_tabs/domain/repositories/app_filter_tabs_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AppFilterTabsRepository)
class AppFilterTabsRepositoryImpl implements AppFilterTabsRepository {
  final AppFilterTabsRemoteDataSourceContract
  appFilterTabsRemoteDataSourceContract;

  AppFilterTabsRepositoryImpl({
    required this.appFilterTabsRemoteDataSourceContract,
  });

  @override
  Future<Result<BasePaginationEntity<AppFilterTabItemEntity>>>
  getAllCategories({required AppFilterTabsParams params}) async {
    late final Result<BasePaginationDto<AppFilterTabItemDto>> result;
    switch (params.type) {
      case AppFilterTabsType.categories:
        result = await appFilterTabsRemoteDataSourceContract.getAllCategories(
          params: params,
        );
      case AppFilterTabsType.occasions:
        result = await appFilterTabsRemoteDataSourceContract.getAllOccasions(
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
        data: data?.toEntity() as BasePaginationEntity<AppFilterTabItemEntity>?,
      ),
      error: (exception) => Error(exception: exception),
    );
  }
}
