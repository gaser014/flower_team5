import 'package:dio/dio.dart';
import 'package:flowers_app/config/api/end_points.dart';
import 'package:flowers_app/features/cart/data/models/cart_response.dart';
import 'package:flowers_app/features/cart/data/models/post/cart_product_post_data.dart';
import 'package:flowers_app/features/cart/data/models/post/cart_update_data.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'cart_api_client.g.dart';

@Injectable()
@RestApi(baseUrl: EndPoints.baseUrl)
abstract interface class CartApiClient {
  @factoryMethod
  factory CartApiClient(Dio dio) => _CartApiClient(dio);

  @GET(EndPoints.cartEndPoint)
  Future<CartResponse> getCartData();

  @POST(EndPoints.cartEndPoint)
  Future<void> addItemToCart(@Body() CartProductPostData data);

  @DELETE("${EndPoints.cartEndPoint}/{id}")
  Future<void> removeItemFromCart(@Path() String id);

  @PUT("${EndPoints.cartEndPoint}/{id}")
  Future<void> updateItemInCart(
    @Path() String id,
    @Body() CartUpdateDataModel data,
  );

  @DELETE(EndPoints.cartEndPoint)
  Future<void> clearUserCart();
}
