import 'package:flowers_app/features/products/domain/entities/product_entity.dart';

sealed class CartEvents {}

class GetCartDataEvent extends CartEvents {}

class IncrementProductEvent extends CartEvents {
  final ProductEntity product;
  IncrementProductEvent(this.product);
}

class DecrementProductEvent extends CartEvents {
  final String productId;
  DecrementProductEvent(this.productId);
}

class RemoveProductFromCartEvent extends CartEvents {
  final String productId;
  RemoveProductFromCartEvent({required this.productId});
}

class UpdateProductInCartEvent extends CartEvents {
  final String productId;
  final int quantity;
  UpdateProductInCartEvent({required this.productId, required this.quantity});
}

class AddProductToCartEvent extends CartEvents {
  final String productId;
  AddProductToCartEvent({required this.productId});
}

class ClearUserCartEvent extends CartEvents {}
