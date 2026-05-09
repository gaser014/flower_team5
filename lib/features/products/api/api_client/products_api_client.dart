import 'package:dio/dio.dart';
import 'package:flowers_app/features/products/data/models/products_response_dto.dart';
import 'package:flowers_app/features/products/domain/entities/products_params.dart';
import 'package:injectable/injectable.dart';
import 'package:flowers_app/config/api/end_points.dart';
import 'package:flowers_app/features/categories/domain/entities/categories_params.dart';
import 'package:retrofit/retrofit.dart';
part 'products_api_client.g.dart';

@lazySingleton
@RestApi(baseUrl: EndPoints.baseUrl)
abstract interface class ProductsApiClient {
  @factoryMethod
  factory ProductsApiClient(Dio dio) => _ProductsApiClient(dio);

  @GET(EndPoints.getAllProducts)
  Future<ProductsResponseDto> getAllProducts(@Queries() ProductsParams params);
}
