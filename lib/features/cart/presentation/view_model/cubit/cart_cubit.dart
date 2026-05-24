import 'dart:async';

import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/config/base_state/base_state.dart';
import 'package:flowers_app/features/cart/data/models/post/cart_product_post_data.dart';
import 'package:flowers_app/features/cart/data/models/post/cart_update_data.dart';
import 'package:flowers_app/features/cart/domain/entities/cart_entity.dart';
import 'package:flowers_app/features/cart/domain/use_cases/add_product_to_cart_use_case.dart';
import 'package:flowers_app/features/cart/domain/use_cases/clear_user_cart_use_case.dart';
import 'package:flowers_app/features/cart/domain/use_cases/get_cart_data_use_case.dart';
import 'package:flowers_app/features/cart/domain/use_cases/remove_product_from_cart_use_case.dart';
import 'package:flowers_app/features/cart/domain/use_cases/update_product_in_cart_usecase.dart';
import 'package:flowers_app/features/cart/presentation/view_model/cubit/cart_events.dart';
import 'package:flowers_app/features/cart/presentation/view_model/cubit/cart_states.dart';
import 'package:flowers_app/features/products/domain/entities/product_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class CartCubit extends Cubit<CartStates> {
  CartCubit({
    required GetCartDataUseCase getCartDataUseCase,
    required AddProductToCartUseCase addProductToCartUseCase,
    required RemoveProductFromCartUseCase removeProductFromCartUseCase,
    required ClearUserCartUseCase clearUserCartUseCase,
    required UpdateProductInCartUsecase updateProductInCartUseCase,
  }) : _getCartDataUseCase = getCartDataUseCase,
       _addProductToCartUseCase = addProductToCartUseCase,
       _removeProductFromCartUseCase = removeProductFromCartUseCase,
       _clearUserCartUseCase = clearUserCartUseCase,
       _updateProductInCartUsecase = updateProductInCartUseCase,
       super(CartStates.initial());

  final GetCartDataUseCase _getCartDataUseCase;
  final AddProductToCartUseCase _addProductToCartUseCase;
  final RemoveProductFromCartUseCase _removeProductFromCartUseCase;
  final ClearUserCartUseCase _clearUserCartUseCase;
  final UpdateProductInCartUsecase _updateProductInCartUsecase;

  static const Duration _debounceDuration = Duration(milliseconds: 600);
  static const Duration _maxWait = Duration(seconds: 3);

  final Map<String, Timer> _debounceTimers = {};
  final Map<String, Timer> _maxWaitTimers = {};
  final Map<String, int> _lastSyncedQuantity = {};
  final Map<String, Future<void>> _inFlight = {};

  @override
  void emit(CartStates state) {
    if (!isClosed) super.emit(state);
  }

  @override
  Future<void> close() {
    for (final t in _debounceTimers.values) {
      t.cancel();
    }
    for (final t in _maxWaitTimers.values) {
      t.cancel();
    }
    return super.close();
  }

  Future<dynamic> doIntent(CartEvents event) async {
    switch (event) {
      case GetCartDataEvent():
        await _loadCart();
      case IncrementProductEvent():
        _localIncrement(event.product);
      case DecrementProductEvent():
        _localDecrement(event.productId);
      case RemoveProductFromCartEvent():
        _localRemove(event.productId);
      case ClearUserCartEvent():
        await _clearCart();
      case AddProductToCartEvent():
        _localIncrementById(event.productId);
      case UpdateProductInCartEvent():
        _localSetQuantity(event.productId, event.quantity);
    }
  }

  Future<void> flushPendingSyncs() async {
    final pendingIds = _debounceTimers.keys.toList();
    for (final id in pendingIds) {
      _debounceTimers.remove(id)?.cancel();
      _maxWaitTimers.remove(id)?.cancel();
      await _syncProduct(id);
    }
  }

  Future<void> _loadCart() async {
    emit(state.copyWith(state: const BaseState<CartEntity>.loading()));

    final result = await _getCartDataUseCase();
    switch (result) {
      case Success<CartEntity>():
        final cart = result.data ?? CartEntity.empty();
        _lastSyncedQuantity
          ..clear()
          ..addEntries(
            cart.cartProductsMap.entries.map(
              (e) => MapEntry(e.key, e.value.productQuantityInCart),
            ),
          );
        emit(
          state.copyWith(
            state: BaseState<CartEntity>.success(cart),
            totalPrice: cart.totalPrice,
          ),
        );
      case Error<CartEntity>():
        emit(
          state.copyWith(state: BaseState<CartEntity>.error(result.exception)),
        );
    }
  }

  Future<void> _clearCart() async {
    emit(state.copyWith(state: const BaseState<CartEntity>.loading()));
    final result = await _clearUserCartUseCase();
    switch (result) {
      case Success<void>():
        _lastSyncedQuantity.clear();
        emit(
          state.copyWith(
            state: BaseState<CartEntity>.success(CartEntity.empty()),
            totalPrice: 0,
          ),
        );
      case Error<void>():
        emit(
          state.copyWith(state: BaseState<CartEntity>.error(result.exception)),
        );
    }
  }

  CartEntity _currentCart() => state.state.data ?? CartEntity.empty();

  void _emitCart(CartEntity cart) {
    emit(
      state.copyWith(
        state: BaseState<CartEntity>.success(cart),
        totalPrice: cart.totalPrice,
      ),
    );
  }

  void _localIncrement(ProductEntity product) {
    final id = product.id;
    if (id == null || id.isEmpty) return;

    final cart = _currentCart();
    final existing = cart.cartProductsMap[id];
    final newMap = Map<String, CartProductEntity>.from(cart.cartProductsMap);

    if (existing != null) {
      newMap[id] = existing.copyWith(
        productQuantityInCart: existing.productQuantityInCart + 1,
      );
    } else {
      newMap[id] = CartProductEntity(
        id: id,
        productName: product.title ?? '',
        productDescription: product.description ?? '',
        productPrice: (product.priceAfterDiscount ?? product.price ?? 0)
            .toDouble(),
        productImage: product.imgCover ?? '',
        productQuantityInCart: 1,
      );
    }

    _emitCart(_recomputeTotals(cart.copyWith(cartProductsMap: newMap)));
    _scheduleSync(id);
  }

  void _localIncrementById(String id) {
    if (id.isEmpty) return;
    final cart = _currentCart();
    final existing = cart.cartProductsMap[id];
    if (existing == null) return;

    final newMap = Map<String, CartProductEntity>.from(cart.cartProductsMap);
    newMap[id] = existing.copyWith(
      productQuantityInCart: existing.productQuantityInCart + 1,
    );
    _emitCart(_recomputeTotals(cart.copyWith(cartProductsMap: newMap)));
    _scheduleSync(id);
  }

  void _localDecrement(String id) {
    if (id.isEmpty) return;
    final cart = _currentCart();
    final existing = cart.cartProductsMap[id];
    if (existing == null) return;

    final newMap = Map<String, CartProductEntity>.from(cart.cartProductsMap);
    final newQty = existing.productQuantityInCart - 1;
    if (newQty <= 0) {
      newMap.remove(id);
    } else {
      newMap[id] = existing.copyWith(productQuantityInCart: newQty);
    }
    _emitCart(_recomputeTotals(cart.copyWith(cartProductsMap: newMap)));
    _scheduleSync(id);
  }

  void _localRemove(String id) {
    if (id.isEmpty) return;
    final cart = _currentCart();
    if (!cart.cartProductsMap.containsKey(id)) return;

    final newMap = Map<String, CartProductEntity>.from(cart.cartProductsMap)
      ..remove(id);
    _emitCart(_recomputeTotals(cart.copyWith(cartProductsMap: newMap)));
    _scheduleSync(id);
  }

  void _localSetQuantity(String id, int qty) {
    if (id.isEmpty) return;
    final cart = _currentCart();
    final existing = cart.cartProductsMap[id];
    final newMap = Map<String, CartProductEntity>.from(cart.cartProductsMap);
    if (qty <= 0) {
      newMap.remove(id);
    } else if (existing != null) {
      newMap[id] = existing.copyWith(productQuantityInCart: qty);
    } else {
      return;
    }
    _emitCart(_recomputeTotals(cart.copyWith(cartProductsMap: newMap)));
    _scheduleSync(id);
  }

  CartEntity _recomputeTotals(CartEntity cart) {
    double total = 0;
    int count = 0;
    for (final p in cart.cartProductsMap.values) {
      total += p.productPrice * p.productQuantityInCart;
      count += p.productQuantityInCart;
    }
    return cart.copyWith(numOfCartItems: count, totalPrice: total);
  }

  void _scheduleSync(String productId) {
    _debounceTimers[productId]?.cancel();
    _debounceTimers[productId] = Timer(_debounceDuration, () {
      _debounceTimers.remove(productId);
      _maxWaitTimers.remove(productId)?.cancel();
      _syncProduct(productId);
    });
    _maxWaitTimers.putIfAbsent(
      productId,
      () => Timer(_maxWait, () {
        _maxWaitTimers.remove(productId);
        _debounceTimers.remove(productId)?.cancel();
        _syncProduct(productId);
      }),
    );
  }

  Future<void> _syncProduct(String productId) async {
    final previous = _inFlight[productId];
    final completer = Completer<void>();
    _inFlight[productId] = completer.future;

    if (previous != null) {
      await previous;
    }

    try {
      await _doSync(productId);
    } finally {
      if (identical(_inFlight[productId], completer.future)) {
        _inFlight.remove(productId);
      }
      completer.complete();
    }
  }

  Future<void> _doSync(String productId) async {
    final lastSynced = _lastSyncedQuantity[productId] ?? 0;
    final currentQty =
        _currentCart().cartProductsMap[productId]?.productQuantityInCart ?? 0;

    if (currentQty == lastSynced) return;

    Result<void> result;

    if (lastSynced == 0 && currentQty > 0) {
      result = await _addProductToCartUseCase(
        CartProductPostData(product: productId),
      );
      if (result is Success<void> && currentQty > 1) {
        result = await _updateProductInCartUsecase(
          productId,
          CartUpdateDataModel(quantity: currentQty),
        );
      }
    } else if (currentQty == 0) {
      result = await _removeProductFromCartUseCase(productId);
    } else {
      result = await _updateProductInCartUsecase(
        productId,
        CartUpdateDataModel(quantity: currentQty),
      );
    }

    switch (result) {
      case Success<void>():
        if (currentQty == 0) {
          _lastSyncedQuantity.remove(productId);
        } else {
          _lastSyncedQuantity[productId] = currentQty;
        }
      case Error<void>():
        _rollback(productId, lastSynced);
        emit(
          state.copyWith(state: BaseState<CartEntity>.error(result.exception)),
        );
        emit(
          state.copyWith(
            state: BaseState<CartEntity>.success(_currentCart()),
            totalPrice: _currentCart().totalPrice,
          ),
        );
    }
  }

  void _rollback(String productId, int lastSyncedQty) {
    final cart = _currentCart();
    final newMap = Map<String, CartProductEntity>.from(cart.cartProductsMap);

    if (lastSyncedQty <= 0) {
      newMap.remove(productId);
    } else {
      final existing = newMap[productId];
      if (existing != null) {
        newMap[productId] = existing.copyWith(
          productQuantityInCart: lastSyncedQty,
        );
      }
    }

    final rolled = _recomputeTotals(cart.copyWith(cartProductsMap: newMap));
    emit(
      state.copyWith(
        state: BaseState<CartEntity>.success(rolled),
        totalPrice: rolled.totalPrice,
      ),
    );
  }
}
