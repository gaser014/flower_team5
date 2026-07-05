import 'package:dio/dio.dart';
import 'package:flowers_app/config/api/end_points.dart';
import 'package:flowers_app/features/product_details/data/models/product_details_response_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'product_details_api_client.g.dart';

@injectable
@RestApi(baseUrl: EndPoints.baseUrl)
abstract class ProductDetailsApiClient {
  @factoryMethod
  factory ProductDetailsApiClient(Dio dio) = _ProductDetailsApiClient;

  @GET('${EndPoints.productsEndpoint}/{id}')
  Future<ProductDetailsResponseDto> getProductDetails(
    @Path('id') String id,
  );
}
