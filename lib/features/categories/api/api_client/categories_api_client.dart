import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../config/api/end_points.dart';
import '../../data/models/categories_response_model.dart';
import '../../data/models/products_response_model.dart';

part 'categories_api_client.g.dart';

@Injectable()
@RestApi()
abstract class CategoriesApiClient {
  @factoryMethod
  factory CategoriesApiClient(Dio dio) = _CategoriesApiClient;

  @GET(EndPoints.allCategories)
  Future<CategoriesResponseModel> getCategories();

  @GET(EndPoints.allProducts)
  Future<ProductsResponseModel> getProducts(@Query('category') String? categoryId);
}
