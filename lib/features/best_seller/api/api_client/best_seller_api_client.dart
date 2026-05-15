import 'package:dio/dio.dart';
import 'package:flowers_app/config/api/end_points.dart';
import 'package:flowers_app/features/best_seller/data/models/best_seller_response_dto.dart';
import 'package:flowers_app/features/best_seller/data/models/product_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'best_seller_api_client.g.dart';

@injectable
@RestApi(baseUrl: EndPoints.baseUrl)
abstract class BestSellerApiClient {
  @factoryMethod
  factory BestSellerApiClient(Dio dio) = _BestSellerApiClient;

  @GET(EndPoints.bestSellersEndpoint)
  Future<BestSellerResponseDto> getBestSellers({
    @Query('page') int? page,
    @Query('limit') int? limit,
  });
}
