import 'package:dio/dio.dart';
import 'package:flowers_app/config/api/end_points.dart';
import 'package:flowers_app/features/categories/data/models/categories_response_dto.dart';
import 'package:flowers_app/features/categories/domain/entities/categories_params.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
part 'categories_api_client.g.dart';

@lazySingleton
@RestApi(baseUrl: EndPoints.baseUrl)
abstract interface class CategoriesApiClient {
  @factoryMethod
  factory CategoriesApiClient(Dio dio) => _CategoriesApiClient(dio);

  @GET(EndPoints.allCategories)
  Future<CategoriesResponseDto> getAllCategories(
    @Queries() CategoriesParams params,
  );
  @GET(EndPoints.getAllOccasions)
  Future<CategoriesResponseDto> getAllOccasions(
    @Queries() CategoriesParams params,
  );
}
