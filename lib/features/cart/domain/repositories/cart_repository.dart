import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/features/cart/data/models/post/cart_product_post_data.dart';
import 'package:flowers_app/features/cart/data/models/post/cart_update_data.dart';
import 'package:flowers_app/features/cart/domain/entities/cart_entity.dart';

abstract interface class CartRepository {
  Future<Result<CartEntity>> getCartData();
  Future<Result<void>> addProductToCart(CartProductPostData data);
  Future<Result<void>> removeProductFromCart(String id);
  Future<Result<void>> clearUserCart();
  Future<Result<void>> updateCartQuantity(String id, CartUpdateDataModel data);
}
