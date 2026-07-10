import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/features/cart/data/models/post/cart_product_post_data.dart';
import 'package:flowers_app/features/cart/data/models/post/cart_update_data.dart';
import 'package:flowers_app/features/cart/domain/entities/cart_entity.dart';
import 'package:flowers_app/features/cart/domain/repositories/cart_repository.dart';
import 'package:flowers_app/features/cart/domain/use_cases/add_product_to_cart_use_case.dart';
import 'package:flowers_app/features/cart/domain/use_cases/clear_user_cart_use_case.dart';
import 'package:flowers_app/features/cart/domain/use_cases/get_cart_data_use_case.dart';
import 'package:flowers_app/features/cart/domain/use_cases/remove_product_from_cart_use_case.dart';
import 'package:flowers_app/features/cart/domain/use_cases/update_product_in_cart_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'cart_use_cases_test.mocks.dart';

@GenerateMocks([CartRepository])
void main() {
  provideDummy<Result<CartEntity>>(const Success<CartEntity>());
  provideDummy<Result<void>>(const Success<void>());

  late MockCartRepository mockRepo;

  setUp(() {
    mockRepo = MockCartRepository();
  });

  // ── Fixtures ─────────────────────────────────────────────────────────────────

  const tProductId = 'prod-1';

  final tCartEntity = CartEntity(
    numOfCartItems: 1,
    totalPrice: 150.0,
    cartProductsMap: {
      tProductId: const CartProductEntity(
        id: tProductId,
        productName: 'Rose',
        productDescription: 'Roses',
        productPrice: 150.0,
        productImage: 'img.jpg',
        productQuantityInCart: 1,
      ),
    },
  );

  // ── GetCartDataUseCase ────────────────────────────────────────────────────────

  group('GetCartDataUseCase', () {
    late GetCartDataUseCase useCase;

    setUp(() => useCase = GetCartDataUseCase(repo: mockRepo));

    test('delegates to repo.getCartData and returns Success', () async {
      when(
        mockRepo.getCartData(),
      ).thenAnswer((_) async => Success<CartEntity>(data: tCartEntity));

      final result = await useCase();

      expect(result, isA<Success<CartEntity>>());
      expect((result as Success<CartEntity>).data, tCartEntity);
      verify(mockRepo.getCartData()).called(1);
      verifyNoMoreInteractions(mockRepo);
    });

    test('returns Error when repo fails', () async {
      final tException = Exception('network error');
      when(
        mockRepo.getCartData(),
      ).thenAnswer((_) async => Error<CartEntity>(exception: tException));

      final result = await useCase();

      expect(result, isA<Error<CartEntity>>());
      expect((result as Error<CartEntity>).exception, tException);
    });
  });

  // ── AddProductToCartUseCase ───────────────────────────────────────────────────

  group('AddProductToCartUseCase', () {
    late AddProductToCartUseCase useCase;

    setUp(() => useCase = AddProductToCartUseCase(repo: mockRepo));

    test('delegates to repo.addProductToCart and returns Success', () async {
      final tData = CartProductPostData(product: tProductId);
      when(
        mockRepo.addProductToCart(any),
      ).thenAnswer((_) async => const Success<void>());

      final result = await useCase(tData);

      expect(result, isA<Success<void>>());
      verify(mockRepo.addProductToCart(any)).called(1);
      verifyNoMoreInteractions(mockRepo);
    });

    test('returns Error when repo fails', () async {
      final tData = CartProductPostData(product: tProductId);
      final tException = Exception('add failed');
      when(
        mockRepo.addProductToCart(any),
      ).thenAnswer((_) async => Error<void>(exception: tException));

      final result = await useCase(tData);

      expect(result, isA<Error<void>>());
    });
  });

  // ── RemoveProductFromCartUseCase ──────────────────────────────────────────────

  group('RemoveProductFromCartUseCase', () {
    late RemoveProductFromCartUseCase useCase;

    setUp(() => useCase = RemoveProductFromCartUseCase(repo: mockRepo));

    test(
      'delegates to repo.removeProductFromCart and returns Success',
      () async {
        when(
          mockRepo.removeProductFromCart(tProductId),
        ).thenAnswer((_) async => const Success<void>());

        final result = await useCase(tProductId);

        expect(result, isA<Success<void>>());
        verify(mockRepo.removeProductFromCart(tProductId)).called(1);
        verifyNoMoreInteractions(mockRepo);
      },
    );

    test('returns Error when repo fails', () async {
      final tException = Exception('remove failed');
      when(
        mockRepo.removeProductFromCart(tProductId),
      ).thenAnswer((_) async => Error<void>(exception: tException));

      final result = await useCase(tProductId);

      expect(result, isA<Error<void>>());
    });
  });

  // ── ClearUserCartUseCase ──────────────────────────────────────────────────────

  group('ClearUserCartUseCase', () {
    late ClearUserCartUseCase useCase;

    setUp(() => useCase = ClearUserCartUseCase(repo: mockRepo));

    test('delegates to repo.clearUserCart and returns Success', () async {
      when(
        mockRepo.clearUserCart(),
      ).thenAnswer((_) async => const Success<void>());

      final result = await useCase();

      expect(result, isA<Success<void>>());
      verify(mockRepo.clearUserCart()).called(1);
      verifyNoMoreInteractions(mockRepo);
    });

    test('returns Error when repo fails', () async {
      final tException = Exception('clear failed');
      when(
        mockRepo.clearUserCart(),
      ).thenAnswer((_) async => Error<void>(exception: tException));

      final result = await useCase();

      expect(result, isA<Error<void>>());
    });
  });

  // ── UpdateProductInCartUsecase ────────────────────────────────────────────────

  group('UpdateProductInCartUsecase', () {
    late UpdateProductInCartUsecase useCase;

    setUp(() => useCase = UpdateProductInCartUsecase(repo: mockRepo));

    test('delegates to repo.updateCartQuantity and returns Success', () async {
      final tUpdateData = CartUpdateDataModel(quantity: 3);
      when(
        mockRepo.updateCartQuantity(tProductId, any),
      ).thenAnswer((_) async => const Success<void>());

      final result = await useCase(tProductId, tUpdateData);

      expect(result, isA<Success<void>>());
      verify(mockRepo.updateCartQuantity(tProductId, any)).called(1);
      verifyNoMoreInteractions(mockRepo);
    });

    test('returns Error when repo fails', () async {
      final tUpdateData = CartUpdateDataModel(quantity: 3);
      final tException = Exception('update failed');
      when(
        mockRepo.updateCartQuantity(tProductId, any),
      ).thenAnswer((_) async => Error<void>(exception: tException));

      final result = await useCase(tProductId, tUpdateData);

      expect(result, isA<Error<void>>());
    });
  });
}
