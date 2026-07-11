import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/config/error_handling/failures.dart';
import 'package:flowers_app/features/cart/data/datasources/cart_remote_data_source_contract.dart';
import 'package:flowers_app/features/cart/data/models/cart_response.dart';
import 'package:flowers_app/features/cart/data/models/post/cart_product_post_data.dart';
import 'package:flowers_app/features/cart/data/models/post/cart_update_data.dart';
import 'package:flowers_app/features/cart/data/repositories/cart_repository_impl.dart';
import 'package:flowers_app/features/cart/domain/entities/cart_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'cart_repository_impl_test.mocks.dart';

@GenerateMocks([CartRemoteDataSourceContract])
void main() {
  provideDummy<Result<CartResponse>>(const Success<CartResponse>());
  provideDummy<Result<void>>(const Success<void>());

  late CartRepositoryImpl cartRepositoryImpl;
  late MockCartRemoteDataSourceContract mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockCartRemoteDataSourceContract();
    cartRepositoryImpl = CartRepositoryImpl(
      cartRemoteDataSourceContract: mockRemoteDataSource,
    );
  });

  group('getCartData', () {
    final tCartResponse = CartResponse(
      message: 'success',
      numOfCartItems: 2,
      cart: CartData(
        id: 'cart-1',
        user: 'user-1',
        cartItems: [
          CartItem(
            cartProduct: CartProduct(
              id: 'prod-1',
              title: 'Rose Bouquet',
              slug: 'rose-bouquet',
              description: 'Beautiful roses',
              imgCover:
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTpPwNuPuEX-MKyjz91kZ8nAmH2txGUC0zSIg&s',
              images: [],
              price: 150,
              priceAfterDiscount: 120,
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
            ),
            price: 150,
            quantity: 2,
            id: 'item-1',
          ),
        ],
        appliedCoupons: [],
        totalPrice: 300,
        createdAt: null,
        updatedAt: null,
        v: 0,
      ),
    );

    test(
      'should return Success<CartEntity> when remote call succeeds',
      () async {
        when(
          mockRemoteDataSource.getCartData(),
        ).thenAnswer((_) async => Success<CartResponse>(data: tCartResponse));

        final result = await cartRepositoryImpl.getCartData();

        expect(result, isA<Success<CartEntity>>());
        final success = result as Success<CartEntity>;
        expect(success.data?.numOfCartItems, 2);
        expect(success.data?.totalPrice, 300.0);
        expect(success.data?.cartProductsMap.containsKey('prod-1'), true);
        verify(mockRemoteDataSource.getCartData()).called(1);
      },
    );

    test('should return Error<CartEntity> when remote call fails', () async {
      final tException = Exception('network error');

      when(
        mockRemoteDataSource.getCartData(),
      ).thenAnswer((_) async => Error<CartResponse>(exception: tException));

      final result = await cartRepositoryImpl.getCartData();

      expect(result, isA<Error<CartEntity>>());
      final error = result as Error<CartEntity>;
      expect(error.exception, isA<ServerFailure>());
      expect(
        (error.exception as ServerFailure).errorMessage,
        contains('network error'),
      );
      verify(mockRemoteDataSource.getCartData()).called(1);
    });

    test(
      'should return Success<CartEntity> with empty entity when cart is null',
      () async {
        final tEmptyCartResponse = CartResponse(
          message: 'success',
          numOfCartItems: 0,
          cart: null,
        );

        when(mockRemoteDataSource.getCartData()).thenAnswer(
          (_) async => Success<CartResponse>(data: tEmptyCartResponse),
        );

        final result = await cartRepositoryImpl.getCartData();

        expect(result, isA<Success<CartEntity>>());
        final entity = (result as Success<CartEntity>).data;
        expect(entity?.numOfCartItems, 0);
        expect(entity?.totalPrice, 0.0);
        expect(entity?.cartProductsMap.isEmpty, true);
      },
    );

    test(
      'should return Success with null data when response data is null',
      () async {
        when(
          mockRemoteDataSource.getCartData(),
        ).thenAnswer((_) async => const Success<CartResponse>());

        final result = await cartRepositoryImpl.getCartData();

        expect(result, isA<Success<CartEntity>>());
        expect((result as Success<CartEntity>).data, isNull);
      },
    );
  });

  group('addProductToCart', () {
    final tPostData = CartProductPostData(product: 'prod-1', quantity: 1);

    test('should return Success<void> when add product succeeds', () async {
      when(
        mockRemoteDataSource.addProductToCart(any),
      ).thenAnswer((_) async => const Success<void>());

      final result = await cartRepositoryImpl.addProductToCart(tPostData);

      expect(result, isA<Success<void>>());
      verify(mockRemoteDataSource.addProductToCart(any)).called(1);
    });

    test('should return Error<void> when add product fails', () async {
      final tException = Exception('add to cart failed');

      when(
        mockRemoteDataSource.addProductToCart(any),
      ).thenAnswer((_) async => Error<void>(exception: tException));

      final result = await cartRepositoryImpl.addProductToCart(tPostData);

      expect(result, isA<Error<void>>());
      expect(
        ((result as Error<void>).exception as ServerFailure).errorMessage,
        contains('add to cart failed'),
      );
      verify(mockRemoteDataSource.addProductToCart(any)).called(1);
    });
  });

  group('removeProductFromCart', () {
    const tProductId = 'prod-1';

    test('should return Success<void> when remove product succeeds', () async {
      when(
        mockRemoteDataSource.removeProductFromCart(tProductId),
      ).thenAnswer((_) async => const Success<void>());

      final result = await cartRepositoryImpl.removeProductFromCart(tProductId);

      expect(result, isA<Success<void>>());
      verify(mockRemoteDataSource.removeProductFromCart(tProductId)).called(1);
    });

    test('should return Error<void> when remove product fails', () async {
      final tException = Exception('remove failed');

      when(
        mockRemoteDataSource.removeProductFromCart(tProductId),
      ).thenAnswer((_) async => Error<void>(exception: tException));

      final result = await cartRepositoryImpl.removeProductFromCart(tProductId);

      expect(result, isA<Error<void>>());
      expect(
        ((result as Error<void>).exception as ServerFailure).errorMessage,
        contains('remove failed'),
      );
      verify(mockRemoteDataSource.removeProductFromCart(tProductId)).called(1);
    });
  });

  group('clearUserCart', () {
    test('should return Success<void> when clear cart succeeds', () async {
      when(
        mockRemoteDataSource.clearUserCart(),
      ).thenAnswer((_) async => const Success<void>());

      final result = await cartRepositoryImpl.clearUserCart();

      expect(result, isA<Success<void>>());
      verify(mockRemoteDataSource.clearUserCart()).called(1);
    });

    test('should return Error<void> when clear cart fails', () async {
      final tException = Exception('clear cart failed');

      when(
        mockRemoteDataSource.clearUserCart(),
      ).thenAnswer((_) async => Error<void>(exception: tException));

      final result = await cartRepositoryImpl.clearUserCart();

      expect(result, isA<Error<void>>());
      expect(
        ((result as Error<void>).exception as ServerFailure).errorMessage,
        contains('clear cart failed'),
      );
      verify(mockRemoteDataSource.clearUserCart()).called(1);
    });
  });

  group('updateCartQuantity', () {
    const tId = 'item-1';
    final tUpdateData = CartUpdateDataModel(quantity: 3);

    test('should return Success<void> when update quantity succeeds', () async {
      when(
        mockRemoteDataSource.updateCartQuantity(tId, any),
      ).thenAnswer((_) async => const Success<void>());

      final result = await cartRepositoryImpl.updateCartQuantity(
        tId,
        tUpdateData,
      );

      expect(result, isA<Success<void>>());
      verify(mockRemoteDataSource.updateCartQuantity(tId, any)).called(1);
    });

    test('should return Error<void> when update quantity fails', () async {
      final tException = Exception('update quantity failed');

      when(
        mockRemoteDataSource.updateCartQuantity(tId, any),
      ).thenAnswer((_) async => Error<void>(exception: tException));

      final result = await cartRepositoryImpl.updateCartQuantity(
        tId,
        tUpdateData,
      );

      expect(result, isA<Error<void>>());
      expect(
        ((result as Error<void>).exception as ServerFailure).errorMessage,
        contains('update quantity failed'),
      );
      verify(mockRemoteDataSource.updateCartQuantity(tId, any)).called(1);
    });
  });
}
