import 'package:bloc_test/bloc_test.dart';
import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/config/base_state/base_state.dart';
import 'package:flowers_app/config/error_handling/failures.dart';
import 'package:flowers_app/features/cart/domain/entities/cart_entity.dart';
import 'package:flowers_app/features/cart/domain/use_cases/add_product_to_cart_use_case.dart';
import 'package:flowers_app/features/cart/domain/use_cases/clear_user_cart_use_case.dart';
import 'package:flowers_app/features/cart/domain/use_cases/get_cart_data_use_case.dart';
import 'package:flowers_app/features/cart/domain/use_cases/remove_product_from_cart_use_case.dart';
import 'package:flowers_app/features/cart/domain/use_cases/update_product_in_cart_usecase.dart';
import 'package:flowers_app/features/cart/presentation/view_model/cart_sync_service.dart';
import 'package:flowers_app/features/cart/presentation/view_model/cubit/cart_cubit.dart';
import 'package:flowers_app/features/cart/presentation/view_model/cubit/cart_events.dart';
import 'package:flowers_app/features/cart/presentation/view_model/cubit/cart_states.dart';
import 'package:flowers_app/features/products/domain/entities/product_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'cart_cubit_test.mocks.dart';

@GenerateMocks([
  GetCartDataUseCase,
  AddProductToCartUseCase,
  RemoveProductFromCartUseCase,
  ClearUserCartUseCase,
  UpdateProductInCartUsecase,
])
void main() {
  // ── Dummy providers ──────────────────────────────────────────────────────────
  provideDummy<Result<CartEntity>>(const Success<CartEntity>());
  provideDummy<Result<void>>(const Success<void>());

  // ── Shared fixtures ──────────────────────────────────────────────────────────

  const tProductId = 'prod-1';

  const tCartProduct = CartProductEntity(
    id: tProductId,
    productName: 'Rose Bouquet',
    productDescription: 'Beautiful roses',
    productPrice: 150.0,
    productImage:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTpPwNuPuEX-MKyjz91kZ8nAmH2txGUC0zSIg&s',
    productQuantityInCart: 1,
  );

  final tCartEntity = CartEntity(
    numOfCartItems: 1,
    totalPrice: 150.0,
    cartProductsMap: {tProductId: tCartProduct},
  );

  const tProductEntity = ProductEntity(
    id: tProductId,
    title: 'Rose Bouquet',
    description: 'Beautiful roses',
    imgCover:
        'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTpPwNuPuEX-MKyjz91kZ8nAmH2txGUC0zSIg&s',
    price: 150,
    priceAfterDiscount: 120,
  );

  // ── Factory ──────────────────────────────────────────────────────────────────

  late MockGetCartDataUseCase mockGetCart;
  late MockAddProductToCartUseCase mockAddProduct;
  late MockRemoveProductFromCartUseCase mockRemoveProduct;
  late MockClearUserCartUseCase mockClearCart;
  late MockUpdateProductInCartUsecase mockUpdateProduct;

  CartCubit buildCubit() => CartCubit(
    getCartDataUseCase: mockGetCart,
    clearUserCartUseCase: mockClearCart,
    cartSyncService: CartSyncService(
      addProductToCartUseCase: mockAddProduct,
      removeProductFromCartUseCase: mockRemoveProduct,
      updateProductInCartUseCase: mockUpdateProduct,
    ),
  );

  setUp(() {
    mockGetCart = MockGetCartDataUseCase();
    mockAddProduct = MockAddProductToCartUseCase();
    mockRemoveProduct = MockRemoveProductFromCartUseCase();
    mockClearCart = MockClearUserCartUseCase();
    mockUpdateProduct = MockUpdateProductInCartUsecase();
  });

  // ── Initial state ─────────────────────────────────────────────────────────────

  group('initial state', () {
    test('emits CartStates.initial()', () {
      final cubit = buildCubit();
      expect(cubit.state, CartStates.initial());
      expect(cubit.state.totalPrice, 0.0);
      expect(cubit.state.state.isInitial, true);
      cubit.close();
    });
  });

  // ── GetCartDataEvent ──────────────────────────────────────────────────────────

  group('GetCartDataEvent', () {
    blocTest<CartCubit, CartStates>(
      'emits [loading, success] when use case returns data',
      build: buildCubit,
      act: (cubit) async {
        when(
          mockGetCart(),
        ).thenAnswer((_) async => Success<CartEntity>(data: tCartEntity));
        await cubit.doIntent(GetCartDataEvent());
      },
      expect: () => [
        CartStates.initial().copyWith(
          state: const BaseState<CartEntity>.loading(),
        ),
        CartStates.initial().copyWith(
          state: BaseState<CartEntity>.success(tCartEntity),
          totalPrice: 150.0,
        ),
      ],
    );

    blocTest<CartCubit, CartStates>(
      'emits [loading, success(empty)] when use case returns null data',
      build: buildCubit,
      act: (cubit) async {
        when(
          mockGetCart(),
        ).thenAnswer((_) async => const Success<CartEntity>());
        await cubit.doIntent(GetCartDataEvent());
      },
      expect: () => [
        CartStates.initial().copyWith(
          state: const BaseState<CartEntity>.loading(),
        ),
        CartStates.initial().copyWith(
          state: BaseState<CartEntity>.success(CartEntity.empty()),
          totalPrice: 0.0,
        ),
      ],
    );

    blocTest<CartCubit, CartStates>(
      'emits [loading, error] when use case returns Error',
      build: buildCubit,
      act: (cubit) async {
        final exception = Exception('network error');
        when(
          mockGetCart(),
        ).thenAnswer((_) async => Error<CartEntity>(exception: exception));
        await cubit.doIntent(GetCartDataEvent());
      },
      expect: () => [
        CartStates.initial().copyWith(
          state: const BaseState<CartEntity>.loading(),
        ),
        isA<CartStates>().having((s) => s.state.isError, 'isError', true),
      ],
    );
  });

  // ── ClearUserCartEvent ────────────────────────────────────────────────────────

  group('ClearUserCartEvent', () {
    blocTest<CartCubit, CartStates>(
      'emits [loading, success(empty)] when clear succeeds',
      build: buildCubit,
      act: (cubit) async {
        when(mockClearCart()).thenAnswer((_) async => const Success<void>());
        await cubit.doIntent(ClearUserCartEvent());
      },
      expect: () => [
        CartStates.initial().copyWith(
          state: const BaseState<CartEntity>.loading(),
        ),
        CartStates.initial().copyWith(
          state: BaseState<CartEntity>.success(CartEntity.empty()),
          totalPrice: 0.0,
        ),
      ],
    );

    blocTest<CartCubit, CartStates>(
      'emits [loading, error] when clear fails',
      build: buildCubit,
      act: (cubit) async {
        final exception = Exception('clear failed');
        when(
          mockClearCart(),
        ).thenAnswer((_) async => Error<void>(exception: exception));
        await cubit.doIntent(ClearUserCartEvent());
      },
      expect: () => [
        CartStates.initial().copyWith(
          state: const BaseState<CartEntity>.loading(),
        ),
        isA<CartStates>().having((s) => s.state.isError, 'isError', true),
      ],
    );
  });

  // ── IncrementProductEvent ─────────────────────────────────────────────────────

  group('IncrementProductEvent', () {
    blocTest<CartCubit, CartStates>(
      'adds new product to empty cart when product is not in cart',
      build: buildCubit,
      act: (cubit) {
        cubit.doIntent(IncrementProductEvent(tProductEntity));
      },
      expect: () => [
        isA<CartStates>().having(
          (s) => s.state.data?.cartProductsMap.containsKey(tProductId),
          'contains product',
          true,
        ),
      ],
    );

    blocTest<CartCubit, CartStates>(
      'increments quantity when product already in cart',
      build: buildCubit,
      seed: () => CartStates.initial().copyWith(
        state: BaseState<CartEntity>.success(tCartEntity),
        totalPrice: 150.0,
      ),
      act: (cubit) {
        cubit.doIntent(IncrementProductEvent(tProductEntity));
      },
      expect: () => [
        isA<CartStates>().having(
          (s) =>
              s.state.data?.cartProductsMap[tProductId]?.productQuantityInCart,
          'quantity after increment',
          2,
        ),
      ],
    );

    blocTest<CartCubit, CartStates>(
      'does nothing when product id is empty',
      build: buildCubit,
      act: (cubit) {
        cubit.doIntent(IncrementProductEvent(const ProductEntity(id: '')));
      },
      expect: () => [],
    );

    blocTest<CartCubit, CartStates>(
      'recalculates totalPrice after increment',
      build: buildCubit,
      seed: () => CartStates.initial().copyWith(
        state: BaseState<CartEntity>.success(tCartEntity),
        totalPrice: 150.0,
      ),
      act: (cubit) {
        cubit.doIntent(IncrementProductEvent(tProductEntity));
      },
      expect: () => [
        isA<CartStates>().having(
          (s) => s.totalPrice,
          'total price after increment',
          // existing CartProductEntity.productPrice = 150, qty 1→2 = 150*2
          300.0,
        ),
      ],
    );
  });

  // ── DecrementProductEvent ─────────────────────────────────────────────────────

  group('DecrementProductEvent', () {
    blocTest<CartCubit, CartStates>(
      'decrements quantity when qty > 1',
      build: buildCubit,
      seed: () => CartStates.initial().copyWith(
        state: BaseState<CartEntity>.success(
          CartEntity(
            numOfCartItems: 2,
            totalPrice: 300.0,
            cartProductsMap: {
              tProductId: tCartProduct.copyWith(productQuantityInCart: 2),
            },
          ),
        ),
        totalPrice: 300.0,
      ),
      act: (cubit) {
        cubit.doIntent(DecrementProductEvent(tProductId));
      },
      expect: () => [
        isA<CartStates>().having(
          (s) =>
              s.state.data?.cartProductsMap[tProductId]?.productQuantityInCart,
          'quantity after decrement',
          1,
        ),
      ],
    );

    blocTest<CartCubit, CartStates>(
      'removes product from cart when qty reaches 0',
      build: buildCubit,
      seed: () => CartStates.initial().copyWith(
        state: BaseState<CartEntity>.success(tCartEntity),
        totalPrice: 150.0,
      ),
      act: (cubit) {
        cubit.doIntent(DecrementProductEvent(tProductId));
      },
      expect: () => [
        isA<CartStates>().having(
          (s) => s.state.data?.cartProductsMap.containsKey(tProductId),
          'product removed',
          false,
        ),
      ],
    );

    blocTest<CartCubit, CartStates>(
      'does nothing when product not in cart',
      build: buildCubit,
      seed: () => CartStates.initial().copyWith(
        state: BaseState<CartEntity>.success(CartEntity.empty()),
      ),
      act: (cubit) {
        cubit.doIntent(DecrementProductEvent(tProductId));
      },
      expect: () => [],
    );

    blocTest<CartCubit, CartStates>(
      'does nothing when id is empty',
      build: buildCubit,
      act: (cubit) {
        cubit.doIntent(DecrementProductEvent(''));
      },
      expect: () => [],
    );
  });

  // ── RemoveProductFromCartEvent ────────────────────────────────────────────────

  group('RemoveProductFromCartEvent', () {
    blocTest<CartCubit, CartStates>(
      'removes product from cart',
      build: buildCubit,
      seed: () => CartStates.initial().copyWith(
        state: BaseState<CartEntity>.success(tCartEntity),
        totalPrice: 150.0,
      ),
      act: (cubit) {
        cubit.doIntent(RemoveProductFromCartEvent(productId: tProductId));
      },
      expect: () => [
        isA<CartStates>().having(
          (s) => s.state.data?.cartProductsMap.isEmpty,
          'cart is empty after remove',
          true,
        ),
      ],
    );

    blocTest<CartCubit, CartStates>(
      'does nothing when product not in cart',
      build: buildCubit,
      seed: () => CartStates.initial().copyWith(
        state: BaseState<CartEntity>.success(CartEntity.empty()),
      ),
      act: (cubit) {
        cubit.doIntent(RemoveProductFromCartEvent(productId: tProductId));
      },
      expect: () => [],
    );

    blocTest<CartCubit, CartStates>(
      'does nothing when id is empty',
      build: buildCubit,
      act: (cubit) {
        cubit.doIntent(RemoveProductFromCartEvent(productId: ''));
      },
      expect: () => [],
    );

    blocTest<CartCubit, CartStates>(
      'recalculates totalPrice to 0 after removing only product',
      build: buildCubit,
      seed: () => CartStates.initial().copyWith(
        state: BaseState<CartEntity>.success(tCartEntity),
        totalPrice: 150.0,
      ),
      act: (cubit) {
        cubit.doIntent(RemoveProductFromCartEvent(productId: tProductId));
      },
      expect: () => [
        isA<CartStates>().having((s) => s.totalPrice, 'totalPrice is 0', 0.0),
      ],
    );
  });

  // ── AddProductToCartEvent ─────────────────────────────────────────────────────

  group('AddProductToCartEvent', () {
    blocTest<CartCubit, CartStates>(
      'increments existing product quantity by 1',
      build: buildCubit,
      seed: () => CartStates.initial().copyWith(
        state: BaseState<CartEntity>.success(tCartEntity),
        totalPrice: 150.0,
      ),
      act: (cubit) {
        cubit.doIntent(AddProductToCartEvent(productId: tProductId));
      },
      expect: () => [
        isA<CartStates>().having(
          (s) =>
              s.state.data?.cartProductsMap[tProductId]?.productQuantityInCart,
          'quantity incremented',
          2,
        ),
      ],
    );

    blocTest<CartCubit, CartStates>(
      'does nothing when product not already in cart',
      build: buildCubit,
      seed: () => CartStates.initial().copyWith(
        state: BaseState<CartEntity>.success(CartEntity.empty()),
      ),
      act: (cubit) {
        cubit.doIntent(AddProductToCartEvent(productId: tProductId));
      },
      expect: () => [],
    );

    blocTest<CartCubit, CartStates>(
      'does nothing when id is empty',
      build: buildCubit,
      act: (cubit) {
        cubit.doIntent(AddProductToCartEvent(productId: ''));
      },
      expect: () => [],
    );
  });

  // ── UpdateProductInCartEvent ──────────────────────────────────────────────────

  group('UpdateProductInCartEvent', () {
    blocTest<CartCubit, CartStates>(
      'sets product quantity to given value',
      build: buildCubit,
      seed: () => CartStates.initial().copyWith(
        state: BaseState<CartEntity>.success(tCartEntity),
        totalPrice: 150.0,
      ),
      act: (cubit) {
        cubit.doIntent(
          UpdateProductInCartEvent(productId: tProductId, quantity: 5),
        );
      },
      expect: () => [
        isA<CartStates>().having(
          (s) =>
              s.state.data?.cartProductsMap[tProductId]?.productQuantityInCart,
          'quantity set to 5',
          5,
        ),
      ],
    );

    blocTest<CartCubit, CartStates>(
      'removes product when quantity set to 0',
      build: buildCubit,
      seed: () => CartStates.initial().copyWith(
        state: BaseState<CartEntity>.success(tCartEntity),
        totalPrice: 150.0,
      ),
      act: (cubit) {
        cubit.doIntent(
          UpdateProductInCartEvent(productId: tProductId, quantity: 0),
        );
      },
      expect: () => [
        isA<CartStates>().having(
          (s) => s.state.data?.cartProductsMap.containsKey(tProductId),
          'product removed',
          false,
        ),
      ],
    );

    blocTest<CartCubit, CartStates>(
      'does nothing when product not in cart and qty > 0',
      build: buildCubit,
      seed: () => CartStates.initial().copyWith(
        state: BaseState<CartEntity>.success(CartEntity.empty()),
      ),
      act: (cubit) {
        cubit.doIntent(
          UpdateProductInCartEvent(productId: tProductId, quantity: 3),
        );
      },
      expect: () => [],
    );

    blocTest<CartCubit, CartStates>(
      'does nothing when id is empty',
      build: buildCubit,
      act: (cubit) {
        cubit.doIntent(UpdateProductInCartEvent(productId: '', quantity: 2));
      },
      expect: () => [],
    );
  });

  // ── Sync: add new product ─────────────────────────────────────────────────────

  group('_doSync — add new product (lastSynced == 0)', () {
    test(
      'calls addProduct then updateProduct when incremented to qty > 1',
      () async {
        when(
          mockAddProduct(any),
        ).thenAnswer((_) async => const Success<void>());
        when(
          mockUpdateProduct(any, any),
        ).thenAnswer((_) async => const Success<void>());

        final cubit = buildCubit();
        // Simulate a fresh product being added with qty=1 already in state.
        // Seed the cubit with an empty cart so lastSynced[prod] = 0.
        cubit.doIntent(IncrementProductEvent(tProductEntity)); // qty → 1
        await cubit.flushPendingSyncs();

        verify(mockAddProduct(any)).called(1);
        // qty is 1, so update should NOT be called.
        verifyNever(mockUpdateProduct(any, any));
        await cubit.close();
      },
    );

    test(
      'calls addProduct AND updateProduct when qty > 1 after flush',
      () async {
        when(
          mockAddProduct(any),
        ).thenAnswer((_) async => const Success<void>());
        when(
          mockUpdateProduct(any, any),
        ).thenAnswer((_) async => const Success<void>());

        final cubit = buildCubit();
        cubit.doIntent(IncrementProductEvent(tProductEntity)); // qty → 1
        cubit.doIntent(IncrementProductEvent(tProductEntity)); // qty → 2
        await cubit.flushPendingSyncs();

        verify(mockAddProduct(any)).called(1);
        verify(mockUpdateProduct(any, any)).called(1);
        await cubit.close();
      },
    );
  });

  // ── Sync: update existing product ────────────────────────────────────────────

  group('_doSync — update existing product (lastSynced > 0)', () {
    test('calls updateProduct when qty changes', () async {
      when(
        mockGetCart(),
      ).thenAnswer((_) async => Success<CartEntity>(data: tCartEntity));
      when(
        mockUpdateProduct(any, any),
      ).thenAnswer((_) async => const Success<void>());

      final cubit = buildCubit();
      // Load cart so lastSynced[prod-1] = 1.
      await cubit.doIntent(GetCartDataEvent());
      // Increment so qty becomes 2.
      cubit.doIntent(IncrementProductEvent(tProductEntity));
      await cubit.flushPendingSyncs();

      verify(mockUpdateProduct(tProductId, any)).called(1);
      await cubit.close();
    });
  });

  // ── Sync: remove product ──────────────────────────────────────────────────────

  group('_doSync — remove product (qty == 0)', () {
    test('calls removeProduct when qty reaches 0', () async {
      when(
        mockGetCart(),
      ).thenAnswer((_) async => Success<CartEntity>(data: tCartEntity));
      when(
        mockRemoveProduct(any),
      ).thenAnswer((_) async => const Success<void>());

      final cubit = buildCubit();
      await cubit.doIntent(GetCartDataEvent());
      // Decrement from 1 → 0 (removes locally).
      cubit.doIntent(DecrementProductEvent(tProductId));
      await cubit.flushPendingSyncs();

      verify(mockRemoveProduct(tProductId)).called(1);
      await cubit.close();
    });
  });

  // ── Sync: rollback on failure ─────────────────────────────────────────────────

  group('_doSync — rollback on failure', () {
    test(
      'rolls back to last synced quantity and emits side effect on error',
      () async {
        when(
          mockGetCart(),
        ).thenAnswer((_) async => Success<CartEntity>(data: tCartEntity));
        final tException = const ServerFailure(errorMessage: 'Out of stock');
        when(
          mockUpdateProduct(any, any),
        ).thenAnswer((_) async => Error<void>(exception: tException));

        final cubit = buildCubit();
        // Subscribe BEFORE the sync fires so no event is missed.
        final sideEffects = <CartUiNotification>[];
        final sub = cubit.uiNotifications.listen(sideEffects.add);

        await cubit.doIntent(GetCartDataEvent());
        cubit.doIntent(IncrementProductEvent(tProductEntity)); // qty → 2
        await cubit.flushPendingSyncs();
        // Yield to event loop so the broadcast stream delivers the event.
        await Future<void>.microtask(() {});

        // Cart should be rolled back to qty = 1.
        expect(
          cubit
              .state
              .state
              .data
              ?.cartProductsMap[tProductId]
              ?.productQuantityInCart,
          1,
        );
        // State should remain success (no error flash).
        expect(cubit.state.state.isSuccess, true);

        // A side effect should have been emitted.
        expect(sideEffects, hasLength(1));
        expect(sideEffects.first, isA<CartSyncFailedNotification>());
        final failed = sideEffects.first as CartSyncFailedNotification;
        expect(failed.productId, tProductId);
        expect(failed.message, 'Out of stock');

        await sub.cancel();
        await cubit.close();
      },
    );

    test(
      'rolls back to empty cart when lastSynced was 0 and add fails',
      () async {
        final tException = Exception('add failed');
        when(
          mockAddProduct(any),
        ).thenAnswer((_) async => Error<void>(exception: tException));

        final cubit = buildCubit();
        // No prior load → lastSynced[prod-1] = 0.
        cubit.doIntent(IncrementProductEvent(tProductEntity)); // qty → 1
        await cubit.flushPendingSyncs();

        // Product should be removed from cart (rolled back to qty=0).
        expect(
          cubit.state.state.data?.cartProductsMap.containsKey(tProductId),
          isFalse,
        );
        await cubit.close();
      },
    );
  });

  // ── CartStates helpers ────────────────────────────────────────────────────────

  group('CartStates.quantityOf', () {
    test('returns correct quantity when product exists', () {
      final state = CartStates.initial().copyWith(
        state: BaseState<CartEntity>.success(tCartEntity),
      );
      expect(state.quantityOf(tProductId), 1);
    });

    test('returns 0 when product not in cart', () {
      final state = CartStates.initial().copyWith(
        state: BaseState<CartEntity>.success(CartEntity.empty()),
      );
      expect(state.quantityOf('unknown'), 0);
    });

    test('returns 0 when state has no data', () {
      expect(CartStates.initial().quantityOf(tProductId), 0);
    });
  });

  // ── _recomputeTotals ──────────────────────────────────────────────────────────

  group('total price recomputation', () {
    test('sums price × quantity across all cart items', () async {
      final cubit = buildCubit();

      const prodA = ProductEntity(
        id: 'a',
        title: 'A',
        price: 100,
        priceAfterDiscount: 80,
      );
      const prodB = ProductEntity(
        id: 'b',
        title: 'B',
        price: 50,
        priceAfterDiscount: 40,
      );

      cubit.doIntent(IncrementProductEvent(prodA)); // a: qty=1, price=80
      cubit.doIntent(IncrementProductEvent(prodA)); // a: qty=2, price=80 × 2
      cubit.doIntent(IncrementProductEvent(prodB)); // b: qty=1, price=40

      // 80×2 + 40×1 = 200
      expect(cubit.state.totalPrice, 200.0);
      await cubit.close();
    });
  });

  // ── flushPendingSyncs ─────────────────────────────────────────────────────────

  group('flushPendingSyncs', () {
    test(
      'triggers pending syncs immediately without waiting for debounce',
      () async {
        when(
          mockAddProduct(any),
        ).thenAnswer((_) async => const Success<void>());

        final cubit = buildCubit();
        cubit.doIntent(IncrementProductEvent(tProductEntity));

        // Flush before debounce timer fires.
        await cubit.flushPendingSyncs();

        verify(mockAddProduct(any)).called(1);
        await cubit.close();
      },
    );
  });

  // ── close() ───────────────────────────────────────────────────────────────────

  group('close()', () {
    test('cancels pending timers and closes side-effect stream', () async {
      final cubit = buildCubit();
      cubit.doIntent(IncrementProductEvent(tProductEntity));

      // Close before debounce fires — should not throw.
      await cubit.close();
      expect(cubit.isClosed, true);
    });
  });

  // ── _messageFor ───────────────────────────────────────────────────────────────

  group('side-effect message', () {
    test(
      'uses Failures.errorMessage when exception is a Failures subclass',
      () async {
        when(
          mockGetCart(),
        ).thenAnswer((_) async => Success<CartEntity>(data: tCartEntity));
        when(mockUpdateProduct(any, any)).thenAnswer(
          (_) async => Error<void>(
            exception: const ServerFailure(errorMessage: 'Server error msg'),
          ),
        );

        final cubit = buildCubit();
        // Subscribe BEFORE any sync fires.
        final sideEffects = <CartUiNotification>[];
        final sub = cubit.uiNotifications.listen(sideEffects.add);

        await cubit.doIntent(GetCartDataEvent());
        cubit.doIntent(IncrementProductEvent(tProductEntity));
        await cubit.flushPendingSyncs();
        await Future<void>.microtask(() {});

        expect(sideEffects, isNotEmpty);
        expect(
          (sideEffects.first as CartSyncFailedNotification).message,
          'Server error msg',
        );
        await sub.cancel();
        await cubit.close();
      },
    );

    test('falls back to toString() for generic exceptions', () async {
      when(
        mockGetCart(),
      ).thenAnswer((_) async => Success<CartEntity>(data: tCartEntity));
      when(mockUpdateProduct(any, any)).thenAnswer(
        (_) async => Error<void>(exception: Exception('generic error')),
      );

      final cubit = buildCubit();
      // Subscribe BEFORE any sync fires.
      final sideEffects = <CartUiNotification>[];
      final sub = cubit.uiNotifications.listen(sideEffects.add);

      await cubit.doIntent(GetCartDataEvent());
      cubit.doIntent(IncrementProductEvent(tProductEntity));
      await cubit.flushPendingSyncs();
      await Future<void>.microtask(() {});

      expect(sideEffects, isNotEmpty);
      expect(
        (sideEffects.first as CartSyncFailedNotification).message,
        contains('generic error'),
      );
      await sub.cancel();
      await cubit.close();
    });
  });
}
