import 'package:flowers_app/features/cart/domain/entities/cart_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tProduct1 = CartProductEntity(
    id: 'prod-1',
    productName: 'Rose Bouquet',
    productDescription: 'Beautiful roses',
    productPrice: 150.0,
    productImage:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTpPwNuPuEX-MKyjz91kZ8nAmH2txGUC0zSIg&s',
    productQuantityInCart: 2,
  );

  const tProduct2 = CartProductEntity(
    id: 'prod-2',
    productName: 'Lily Set',
    productDescription: 'White lilies',
    productPrice: 80.0,
    productImage: 'https://example.com/lily.jpg',
    productQuantityInCart: 1,
  );

  final tCartEntity = CartEntity(
    numOfCartItems: 3,
    totalPrice: 380.0,
    cartProductsMap: {'prod-1': tProduct1, 'prod-2': tProduct2},
  );

  group('CartEntity.empty()', () {
    test('creates entity with zero items, zero price, and empty map', () {
      final empty = CartEntity.empty();
      expect(empty.numOfCartItems, 0);
      expect(empty.totalPrice, 0.0);
      expect(empty.cartProductsMap, isEmpty);
    });

    test('isEmpty returns true for empty cart', () {
      expect(CartEntity.empty().isEmpty, isTrue);
    });
  });

  group('CartEntity.isEmpty', () {
    test('returns false when cart has products', () {
      expect(tCartEntity.isEmpty, isFalse);
    });

    test('returns true when cartProductsMap is empty', () {
      final emptyCart = CartEntity(
        numOfCartItems: 0,
        totalPrice: 0,
        cartProductsMap: {},
      );
      expect(emptyCart.isEmpty, isTrue);
    });
  });

  group('CartEntity.cartProducts', () {
    test('returns list of all CartProductEntity values', () {
      final products = tCartEntity.cartProducts;
      expect(products, hasLength(2));
      expect(products, containsAll([tProduct1, tProduct2]));
    });

    test('returns empty list for empty cart', () {
      expect(CartEntity.empty().cartProducts, isEmpty);
    });
  });

  group('CartEntity.getQuantity()', () {
    test('returns correct quantity for existing product', () {
      expect(tCartEntity.getQuantity('prod-1'), 2);
      expect(tCartEntity.getQuantity('prod-2'), 1);
    });

    test('returns 0 for product not in cart', () {
      expect(tCartEntity.getQuantity('nonexistent'), 0);
    });
  });

  group('CartEntity.getProduct()', () {
    test('returns entity for existing product', () {
      expect(tCartEntity.getProduct('prod-1'), tProduct1);
    });

    test('returns null for product not in cart', () {
      expect(tCartEntity.getProduct('nonexistent'), isNull);
    });
  });

  group('CartEntity.copyWith()', () {
    test('returns new entity with updated numOfCartItems', () {
      final updated = tCartEntity.copyWith(numOfCartItems: 10);
      expect(updated.numOfCartItems, 10);
      expect(updated.totalPrice, tCartEntity.totalPrice);
      expect(updated.cartProductsMap, tCartEntity.cartProductsMap);
    });

    test('returns new entity with updated totalPrice', () {
      final updated = tCartEntity.copyWith(totalPrice: 999.0);
      expect(updated.totalPrice, 999.0);
      expect(updated.numOfCartItems, tCartEntity.numOfCartItems);
    });

    test('returns new entity with updated cartProductsMap', () {
      final newMap = {'prod-1': tProduct1};
      final updated = tCartEntity.copyWith(cartProductsMap: newMap);
      expect(updated.cartProductsMap, newMap);
    });

    test('returns identical entity when no args provided', () {
      final copy = tCartEntity.copyWith();
      expect(copy, equals(tCartEntity));
    });
  });

  group('CartEntity equality', () {
    test('two entities with same data are equal', () {
      final a = CartEntity(
        numOfCartItems: 1,
        totalPrice: 150.0,
        cartProductsMap: {'prod-1': tProduct1},
      );
      final b = CartEntity(
        numOfCartItems: 1,
        totalPrice: 150.0,
        cartProductsMap: {'prod-1': tProduct1},
      );
      expect(a, equals(b));
    });

    test('two entities with different totalPrice are not equal', () {
      final a = CartEntity(
        numOfCartItems: 1,
        totalPrice: 100.0,
        cartProductsMap: {'prod-1': tProduct1},
      );
      final b = CartEntity(
        numOfCartItems: 1,
        totalPrice: 200.0,
        cartProductsMap: {'prod-1': tProduct1},
      );
      expect(a, isNot(equals(b)));
    });

    test('identical instance equals itself', () {
      expect(tCartEntity, equals(tCartEntity));
    });
  });

  group('CartProductEntity.copyWith()', () {
    test('updates productQuantityInCart', () {
      final updated = tProduct1.copyWith(productQuantityInCart: 5);
      expect(updated.productQuantityInCart, 5);
      expect(updated.id, tProduct1.id);
      expect(updated.productName, tProduct1.productName);
    });

    test('updates productPrice', () {
      final updated = tProduct1.copyWith(productPrice: 200.0);
      expect(updated.productPrice, 200.0);
    });

    test('updates productName', () {
      final updated = tProduct1.copyWith(productName: 'New Name');
      expect(updated.productName, 'New Name');
    });

    test('returns identical entity when no args provided', () {
      final copy = tProduct1.copyWith();
      expect(copy, equals(tProduct1));
    });
  });

  group('CartProductEntity equality', () {
    test('two products with same data are equal', () {
      const a = CartProductEntity(
        id: 'prod-1',
        productName: 'Rose Bouquet',
        productDescription: 'Beautiful roses',
        productPrice: 150.0,
        productImage:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTpPwNuPuEX-MKyjz91kZ8nAmH2txGUC0zSIg&s',
        productQuantityInCart: 2,
      );
      expect(a, equals(tProduct1));
    });

    test('two products with different id are not equal', () {
      final different = tProduct1.copyWith(id: 'other-id');
      expect(different, isNot(equals(tProduct1)));
    });

    test('two products with different quantity are not equal', () {
      final different = tProduct1.copyWith(productQuantityInCart: 99);
      expect(different, isNot(equals(tProduct1)));
    });

    test('hashCode matches for equal objects', () {
      const a = CartProductEntity(
        id: 'prod-1',
        productName: 'Rose Bouquet',
        productDescription: 'Beautiful roses',
        productPrice: 150.0,
        productImage:
            'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTpPwNuPuEX-MKyjz91kZ8nAmH2txGUC0zSIg&s',
        productQuantityInCart: 2,
      );
      expect(a.hashCode, equals(tProduct1.hashCode));
    });
  });
}
