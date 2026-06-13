import 'dart:convert';

import 'package:flowers_app/features/cart/data/models/cart_response.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  CartProduct buildProduct({
    String? id = 'prod-1',
    String? title = 'Rose Bouquet',
    String? description = 'Beautiful roses',
    String? imgCover =
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTpPwNuPuEX-MKyjz91kZ8nAmH2txGUC0zSIg&s',
  }) => CartProduct(
    id: id,
    title: title,
    slug: 'rose-bouquet',
    description: description,
    imgCover: imgCover,
    images: [],
    price: 200,
    priceAfterDiscount: 150,
    quantity: 10,
    category: 'cat-1',
    occasion: 'occ-1',
    createdAt: null,
    updatedAt: null,
    v: 0,
    sold: 5,
    isSuperAdmin: false,
    rateAvg: 4.5,
    rateCount: 20,
    cartProductId: 'cp-1',
  );

  CartItem buildItem({
    CartProduct? product,
    num price = 150,
    num quantity = 2,
    String id = 'item-1',
  }) => CartItem(
    cartProduct: product ?? buildProduct(),
    price: price,
    quantity: quantity,
    id: id,
  );

  Cart buildCart({List<CartItem>? items, num? totalPrice = 300}) => Cart(
    id: 'cart-1',
    user: 'user-1',
    cartItems: items,
    appliedCoupons: [],
    totalPrice: totalPrice,
    createdAt: null,
    updatedAt: null,
    v: 0,
  );

  group('CartResponse.toCartEntity()', () {
    test('maps cart items to CartEntity correctly', () {
      final response = CartResponse(
        message: 'success',
        numOfCartItems: 2,
        cart: buildCart(items: [buildItem()]),
      );

      final entity = response.toCartEntity();

      expect(entity.numOfCartItems, 2);
      expect(entity.totalPrice, 300.0);
      expect(entity.cartProductsMap.containsKey('prod-1'), isTrue);

      final product = entity.cartProductsMap['prod-1']!;
      expect(product.productName, 'Rose Bouquet');
      expect(product.productDescription, 'Beautiful roses');
      expect(product.productPrice, 150.0);
      expect(
        product.productImage,
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTpPwNuPuEX-MKyjz91kZ8nAmH2txGUC0zSIg&s',
      );
      expect(product.productQuantityInCart, 2);
    });

    test('returns empty entity when cart is null', () {
      final response = CartResponse(
        message: 'success',
        numOfCartItems: 0,
        cart: null,
      );

      final entity = response.toCartEntity();

      expect(entity.numOfCartItems, 0);
      expect(entity.totalPrice, 0.0);
      expect(entity.cartProductsMap, isEmpty);
    });

    test('returns zero totalPrice when cart.totalPrice is null', () {
      final response = CartResponse(
        message: 'success',
        numOfCartItems: 0,
        cart: buildCart(items: [], totalPrice: null),
      );

      final entity = response.toCartEntity();
      expect(entity.totalPrice, 0.0);
    });

    test('returns 0 numOfCartItems when numOfCartItems is null', () {
      final response = CartResponse(
        message: 'success',
        numOfCartItems: null,
        cart: buildCart(items: []),
      );

      final entity = response.toCartEntity();
      expect(entity.numOfCartItems, 0);
    });

    test('skips cart items where product id is empty string', () {
      final itemWithEmptyId = buildItem(product: buildProduct(id: ''));
      final response = CartResponse(
        message: 'success',
        numOfCartItems: 0,
        cart: buildCart(items: [itemWithEmptyId]),
      );

      final entity = response.toCartEntity();
      expect(entity.cartProductsMap, isEmpty);
    });

    test('skips cart items where product id is null', () {
      final itemWithNullId = buildItem(product: buildProduct(id: null));
      final response = CartResponse(
        message: 'success',
        numOfCartItems: 0,
        cart: buildCart(items: [itemWithNullId]),
      );

      final entity = response.toCartEntity();
      expect(entity.cartProductsMap, isEmpty);
    });

    test('handles multiple cart items', () {
      final items = [
        buildItem(
          product: buildProduct(id: 'prod-1', title: 'Rose'),
          price: 100,
          quantity: 1,
          id: 'item-1',
        ),
        buildItem(
          product: buildProduct(id: 'prod-2', title: 'Lily'),
          price: 50,
          quantity: 3,
          id: 'item-2',
        ),
      ];
      final response = CartResponse(
        message: 'success',
        numOfCartItems: 4,
        cart: buildCart(items: items, totalPrice: 250),
      );

      final entity = response.toCartEntity();
      expect(entity.cartProductsMap, hasLength(2));
      expect(entity.cartProductsMap.containsKey('prod-1'), isTrue);
      expect(entity.cartProductsMap.containsKey('prod-2'), isTrue);
    });

    test('last item wins when duplicate product ids exist', () {
      final items = [
        buildItem(
          product: buildProduct(id: 'prod-1', title: 'First'),
          quantity: 1,
          id: 'item-1',
        ),
        buildItem(
          product: buildProduct(id: 'prod-1', title: 'Second'),
          quantity: 5,
          id: 'item-2',
        ),
      ];
      final response = CartResponse(
        message: 'success',
        numOfCartItems: 2,
        cart: buildCart(items: items),
      );

      final entity = response.toCartEntity();
      expect(entity.cartProductsMap, hasLength(1));
      expect(entity.cartProductsMap['prod-1']?.productQuantityInCart, 5);
    });
  });

  group('CartItem.toCartProductEntity()', () {
    test('maps all fields correctly', () {
      final item = buildItem();
      final entity = item.toCartProductEntity();

      expect(entity.id, 'prod-1');
      expect(entity.productName, 'Rose Bouquet');
      expect(entity.productDescription, 'Beautiful roses');
      expect(entity.productPrice, 150.0);
      expect(
        entity.productImage,
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTpPwNuPuEX-MKyjz91kZ8nAmH2txGUC0zSIg&s',
      );
      expect(entity.productQuantityInCart, 2);
    });

    test('uses empty string fallbacks when product fields are null', () {
      final item = CartItem(
        cartProduct: CartProduct(
          id: null,
          title: null,
          slug: null,
          description: null,
          imgCover: null,
          images: null,
          price: null,
          priceAfterDiscount: null,
          quantity: null,
          category: null,
          occasion: null,
          createdAt: null,
          updatedAt: null,
          v: null,
          sold: null,
          isSuperAdmin: null,
          rateAvg: null,
          rateCount: null,
          cartProductId: null,
        ),
        price: null,
        quantity: null,
        id: 'item-1',
      );

      final entity = item.toCartProductEntity();

      expect(entity.id, '');
      expect(entity.productName, '');
      expect(entity.productDescription, '');
      expect(entity.productPrice, 0.0);
      expect(entity.productImage, '');
      expect(entity.productQuantityInCart, 0);
    });

    test('uses 0 fallbacks when price and quantity are null', () {
      final item = CartItem(
        cartProduct: buildProduct(),
        price: null,
        quantity: null,
        id: 'item-1',
      );

      final entity = item.toCartProductEntity();
      expect(entity.productPrice, 0.0);
      expect(entity.productQuantityInCart, 0);
    });

    test('returns entity with id="" when cartProduct is null', () {
      final item = CartItem(
        cartProduct: null,
        price: 100,
        quantity: 1,
        id: 'item-1',
      );

      final entity = item.toCartProductEntity();
      expect(entity.id, '');
    });
  });

  group('fromJson factories', () {
    const fullJson = '''
{
  "message": "success",
  "numOfCartItems": 1,
  "cart": {
    "_id": "cart-1",
    "user": "user-1",
    "cartItems": [
      {
        "_id": "item-1",
        "product": {
          "_id": "prod-1",
          "title": "Rose Bouquet",
          "slug": "rose-bouquet",
          "description": "Beautiful roses",
          "imgCover": "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTpPwNuPuEX-MKyjz91kZ8nAmH2txGUC0zSIg&s",
          "images": [],
          "price": 200,
          "priceAfterDiscount": 150,
          "quantity": 10,
          "category": "cat-1",
          "occasion": "occ-1",
          "__v": 0,
          "sold": 5,
          "isSuperAdmin": false,
          "rateAvg": 4.5,
          "rateCount": 20,
          "cartProductId": "cp-1"
        },
        "price": 150,
        "quantity": 2
      }
    ],
    "appliedCoupons": [],
    "totalPrice": 300,
    "__v": 0
  }
}
''';

    test('CartResponse.fromJson parses full JSON correctly', () {
      final map = json.decode(fullJson) as Map<String, dynamic>;
      final response = CartResponse.fromJson(map);

      expect(response.message, 'success');
      expect(response.numOfCartItems, 1);
      expect(response.cart, isNotNull);
      expect(response.cart!.id, 'cart-1');
      expect(response.cart!.cartItems, hasLength(1));
    });

    test('Cart.fromJson parses nested cart JSON', () {
      final map =
          (json.decode(fullJson) as Map<String, dynamic>)['cart']
              as Map<String, dynamic>;
      final cart = Cart.fromJson(map);

      expect(cart.id, 'cart-1');
      expect(cart.user, 'user-1');
      expect(cart.totalPrice, 300);
      expect(cart.cartItems, hasLength(1));
    });

    test('CartItem.fromJson parses item JSON', () {
      final cartMap =
          (json.decode(fullJson) as Map<String, dynamic>)['cart']
              as Map<String, dynamic>;
      final itemMap =
          (cartMap['cartItems'] as List).first as Map<String, dynamic>;
      final item = CartItem.fromJson(itemMap);

      expect(item.id, 'item-1');
      expect(item.price, 150);
      expect(item.quantity, 2);
      expect(item.cartProduct, isNotNull);
    });

    test('CartProduct.fromJson parses product JSON', () {
      final cartMap =
          (json.decode(fullJson) as Map<String, dynamic>)['cart']
              as Map<String, dynamic>;
      final productMap =
          ((cartMap['cartItems'] as List).first
                  as Map<String, dynamic>)['product']
              as Map<String, dynamic>;
      final product = CartProduct.fromJson(productMap);

      expect(product.id, 'prod-1');
      expect(product.title, 'Rose Bouquet');
      expect(product.price, 200);
      expect(
        product.imgCover,
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTpPwNuPuEX-MKyjz91kZ8nAmH2txGUC0zSIg&s',
      );
    });

    test(
      'CartResponse.fromJson handles missing optional fields gracefully',
      () {
        final minimalJson =
            json.decode('{"message": "ok"}') as Map<String, dynamic>;
        final response = CartResponse.fromJson(minimalJson);

        expect(response.message, 'ok');
        expect(response.numOfCartItems, isNull);
        expect(response.cart, isNull);
      },
    );
  });
}
