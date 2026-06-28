import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/features/cart/data/models/post/cart_product_post_data.dart';
import 'package:flowers_app/features/cart/data/models/post/cart_update_data.dart';
import 'package:flowers_app/features/cart/domain/use_cases/add_product_to_cart_use_case.dart';
import 'package:flowers_app/features/cart/domain/use_cases/remove_product_from_cart_use_case.dart';
import 'package:flowers_app/features/cart/domain/use_cases/update_product_in_cart_usecase.dart';
import 'package:injectable/injectable.dart';

@injectable
class CartSyncService {
  CartSyncService({
    required AddProductToCartUseCase addProductToCartUseCase,
    required RemoveProductFromCartUseCase removeProductFromCartUseCase,
    required UpdateProductInCartUsecase updateProductInCartUseCase,
  }) : _addProduct = addProductToCartUseCase,
       _removeProduct = removeProductFromCartUseCase,
       _updateProduct = updateProductInCartUseCase;

  final AddProductToCartUseCase _addProduct;
  final RemoveProductFromCartUseCase _removeProduct;
  final UpdateProductInCartUsecase _updateProduct;

  Future<Result<void>> sync({
    required String productId,
    required int previousQuantity,
    required int newQuantity,
  }) async {
    if (newQuantity == 0) {
      return _removeProduct(productId);
    }
    if (previousQuantity > 0) {
      return _updateProduct(
        productId,
        CartUpdateDataModel(quantity: newQuantity),
      );
    }

    final added = await _addProduct(CartProductPostData(product: productId));
    if (added is Success<void> && newQuantity > 1) {
      return _updateProduct(
        productId,
        CartUpdateDataModel(quantity: newQuantity),
      );
    }
    return added;
  }
}
