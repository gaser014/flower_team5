import 'package:flutter/foundation.dart';

class CartEntity {
  final int numOfCartItems;
  final double totalPrice;
  final Map<String, CartProductEntity> cartProductsMap;

  const CartEntity({
    required this.numOfCartItems,
    required this.totalPrice,
    required this.cartProductsMap,
  });

  factory CartEntity.empty() => const CartEntity(
    numOfCartItems: 0,
    totalPrice: 0,
    cartProductsMap: <String, CartProductEntity>{},
  );

  List<CartProductEntity> get cartProducts =>
      cartProductsMap.values.toList(growable: false);

  bool get isEmpty => cartProductsMap.isEmpty;

  int getQuantity(String productId) =>
      cartProductsMap[productId]?.productQuantityInCart ?? 0;

  CartProductEntity? getProduct(String productId) => cartProductsMap[productId];

  CartEntity copyWith({
    int? numOfCartItems,
    double? totalPrice,
    Map<String, CartProductEntity>? cartProductsMap,
  }) {
    return CartEntity(
      numOfCartItems: numOfCartItems ?? this.numOfCartItems,
      totalPrice: totalPrice ?? this.totalPrice,
      cartProductsMap: cartProductsMap ?? this.cartProductsMap,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CartEntity &&
        other.numOfCartItems == numOfCartItems &&
        other.totalPrice == totalPrice &&
        mapEquals(other.cartProductsMap, cartProductsMap);
  }

  @override
  int get hashCode =>
      numOfCartItems.hashCode ^ totalPrice.hashCode ^ cartProductsMap.hashCode;
}

class CartProductEntity {
  final String id;
  final String productName;
  final String productDescription;
  final double productPrice;
  final String productImage;
  final int productQuantityInCart;

  const CartProductEntity({
    required this.id,
    required this.productName,
    required this.productDescription,
    required this.productPrice,
    required this.productImage,
    required this.productQuantityInCart,
  });

  CartProductEntity copyWith({
    String? id,
    String? productName,
    String? productDescription,
    double? productPrice,
    String? productImage,
    int? productQuantityInCart,
  }) {
    return CartProductEntity(
      id: id ?? this.id,
      productName: productName ?? this.productName,
      productDescription: productDescription ?? this.productDescription,
      productPrice: productPrice ?? this.productPrice,
      productImage: productImage ?? this.productImage,
      productQuantityInCart:
          productQuantityInCart ?? this.productQuantityInCart,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is CartProductEntity &&
        other.id == id &&
        other.productName == productName &&
        other.productDescription == productDescription &&
        other.productPrice == productPrice &&
        other.productImage == productImage &&
        other.productQuantityInCart == productQuantityInCart;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      productName.hashCode ^
      productDescription.hashCode ^
      productPrice.hashCode ^
      productImage.hashCode ^
      productQuantityInCart.hashCode;
}
