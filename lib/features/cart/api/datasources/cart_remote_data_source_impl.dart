import 'package:flowers_app/config/api/api_execute.dart';
import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/features/cart/api/api_client/cart_api_client.dart';
import 'package:flowers_app/features/cart/data/datasources/cart_remote_data_source_contract.dart';
import 'package:flowers_app/features/cart/data/models/cart_response.dart';
import 'package:flowers_app/features/cart/data/models/post/cart_product_post_data.dart';
import 'package:flowers_app/features/cart/data/models/post/cart_update_data.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CartRemoteDataSourceContract)
class CartRemoteDataSourceImpl implements CartRemoteDataSourceContract {
  final CartApiClient cartApiClient;

  CartRemoteDataSourceImpl({required this.cartApiClient});

  @override
  Future<Result<CartResponse>> getCartData() {
    return executeApi<CartResponse>(() => cartApiClient.getCartData());
  }

  @override
  Future<Result<void>> addProductToCart(CartProductPostData data) {
    return executeApi<void>(() => cartApiClient.addItemToCart(data));
  }

  @override
  Future<Result<void>> removeProductFromCart(String productId) {
    return executeApi<void>(() => cartApiClient.removeItemFromCart(productId));
  }

  @override
  Future<Result<void>> clearUserCart() {
    return executeApi<void>(() => cartApiClient.clearUserCart());
  }

  @override
  Future<Result<void>> updateCartQuantity(String id, CartUpdateDataModel data) {
    return executeApi<void>(() => cartApiClient.updateItemInCart(id, data));
  }
}
