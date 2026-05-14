import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/features/app_filter_tabs/data/models/categories_response_dto.dart';
import 'package:flowers_app/features/app_filter_tabs/data/models/occasions_response_dto.dart';
import 'package:flowers_app/features/app_filter_tabs/domain/entities/app_filter_tabs_params.dart';

abstract interface class AppFilterTabsRemoteDataSourceContract {
  Future<Result<CategoriesResponseDto>> getAllCategories({
    required AppFilterTabsParams params,
  });
  Future<Result<OccasionsResponseDto>> getAllOccasions({
    required AppFilterTabsParams params,
  });
}
