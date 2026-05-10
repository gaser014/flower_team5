import 'package:flowers_app/config/api/api_execute.dart';
import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/features/app_filter_tabs/api/api_client/app_filter_tabs_api_client.dart';
import 'package:flowers_app/features/app_filter_tabs/data/datasources/app_filter_tabs_remote_data_source_contract.dart';
import 'package:flowers_app/features/app_filter_tabs/data/models/categories_response_dto.dart';
import 'package:flowers_app/features/app_filter_tabs/data/models/occasions_response_dto.dart';
import 'package:flowers_app/features/app_filter_tabs/domain/entities/app_filter_tabs_params.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AppFilterTabsRemoteDataSourceContract)
class AppFilterTabsRemoteDataSourceImpl
    implements AppFilterTabsRemoteDataSourceContract {
  final AppFilterTabsApiClient apiClient;

  AppFilterTabsRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<Result<CategoriesResponseDto>> getAllCategories({
    required AppFilterTabsParams params,
  }) async {
    return await executeApi<CategoriesResponseDto>(
      () => apiClient.getAllCategories(params),
    );
  }

  @override
  Future<Result<OccasionsResponseDto>> getAllOccasions({
    required AppFilterTabsParams params,
  }) async {
    return await executeApi<OccasionsResponseDto>(
      () => apiClient.getAllOccasions(params),
    );
  }
}
