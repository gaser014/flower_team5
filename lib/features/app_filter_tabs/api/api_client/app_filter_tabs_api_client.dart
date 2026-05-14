import 'package:dio/dio.dart';
import 'package:flowers_app/config/api/end_points.dart';
import 'package:flowers_app/features/app_filter_tabs/data/models/categories_response_dto.dart';
import 'package:flowers_app/features/app_filter_tabs/data/models/occasions_response_dto.dart';
import 'package:flowers_app/features/app_filter_tabs/domain/entities/app_filter_tabs_params.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
part 'app_filter_tabs_api_client.g.dart';

@lazySingleton
@RestApi(baseUrl: EndPoints.baseUrl)
abstract interface class AppFilterTabsApiClient {
  @factoryMethod
  factory AppFilterTabsApiClient(Dio dio) => _AppFilterTabsApiClient(dio);

  @GET(EndPoints.allCategories)
  Future<CategoriesResponseDto> getAllCategories(
    @Queries() AppFilterTabsParams params,
  );
  @GET(EndPoints.getAllOccasions)
  Future<OccasionsResponseDto> getAllOccasions(
    @Queries() AppFilterTabsParams params,
  );
}
