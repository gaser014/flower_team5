import 'dart:async';

import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/config/base_state/base_state.dart';
import 'package:flowers_app/config/error_handling/failures.dart';
import 'package:flowers_app/features/cart/domain/entities/cart_entity.dart';
import 'package:flowers_app/features/cart/domain/use_cases/clear_user_cart_use_case.dart';
import 'package:flowers_app/features/cart/domain/use_cases/get_cart_data_use_case.dart';
import 'package:flowers_app/features/cart/presentation/view_model/cart_sync_service.dart';
import 'package:flowers_app/features/cart/presentation/view_model/cubit/cart_events.dart';
import 'package:flowers_app/features/cart/presentation/view_model/cubit/cart_states.dart';
import 'package:flowers_app/features/products/domain/entities/product_entity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

sealed class CartUiNotification {
  const CartUiNotification();
}

class CartSyncFailedNotification extends CartUiNotification {
  final String productId;
  final String message;
  const CartSyncFailedNotification({
    required this.productId,
    required this.message,
  });
}

@lazySingleton
class CartCubit extends Cubit<CartStates> {
  CartCubit({
    required GetCartDataUseCase getCartDataUseCase,
    required ClearUserCartUseCase clearUserCartUseCase,
    required CartSyncService cartSyncService,
  }) : _getCartData = getCartDataUseCase,
       _clearCart = clearUserCartUseCase,
       _syncService = cartSyncService,
       super(CartStates.initial());

  final GetCartDataUseCase _getCartData;
  final ClearUserCartUseCase _clearCart;
  final CartSyncService _syncService;

  static const Duration _debounce = Duration(milliseconds: 600);

  final Map<String, Timer> _pendingSync = {};
  final Map<String, int> _syncedQuantity = {};

  final _notifications = StreamController<CartUiNotification>.broadcast();
  Stream<CartUiNotification> get uiNotifications => _notifications.stream;

  @override
  void emit(CartStates state) {
    if (!isClosed) super.emit(state);
  }

  Future<void> doIntent(CartEvents event) async {
    switch (event) {
      case GetCartDataEvent():
        await _loadCart();
      case ClearUserCartEvent():
        await _clearUserCart();
      case IncrementProductEvent():
        _incrementOrAdd(event.product);
      case AddProductToCartEvent():
        _changeQuantity(event.productId, _quantityOf(event.productId) + 1);
      case DecrementProductEvent():
        _changeQuantity(event.productId, _quantityOf(event.productId) - 1);
      case RemoveProductFromCartEvent():
        _changeQuantity(event.productId, 0);
      case UpdateProductInCartEvent():
        _changeQuantity(event.productId, event.quantity);
    }
  }

  @override
  Future<void> close() {
    for (final timer in _pendingSync.values) {
      timer.cancel();
    }
    _notifications.close();
    return super.close();
  }

  Future<void> _loadCart() async {
    emit(state.copyWith(state: const BaseState.loading()));

    final result = await _getCartData();
    switch (result) {
      case Success<CartEntity>():
        final cart = result.data ?? CartEntity.empty();
        _syncedQuantity
          ..clear()
          ..addAll(
            cart.cartProductsMap.map(
              (id, p) => MapEntry(id, p.productQuantityInCart),
            ),
          );
        emit(
          state.copyWith(
            state: BaseState.success(cart),
            totalPrice: cart.totalPrice,
          ),
        );
      case Error<CartEntity>():
        emit(state.copyWith(state: BaseState.error(result.exception)));
    }
  }

  Future<void> _clearUserCart() async {
    emit(state.copyWith(state: const BaseState.loading()));

    final result = await _clearCart();
    switch (result) {
      case Success<void>():
        _syncedQuantity.clear();
        emit(
          state.copyWith(
            state: BaseState.success(CartEntity.empty()),
            totalPrice: 0,
          ),
        );
      case Error<void>():
        emit(state.copyWith(state: BaseState.error(result.exception)));
    }
  }

  void _incrementOrAdd(ProductEntity product) {
    final id = product.id ?? '';
    if (id.isEmpty) return;

    final products = _productsCopy();
    final existing = products[id];
    products[id] = existing != null
        ? existing.copyWith(
            productQuantityInCart: existing.productQuantityInCart + 1,
          )
        : CartProductEntity(
            id: id,
            productName: product.title ?? '',
            productDescription: product.description ?? '',
            productPrice: (product.priceAfterDiscount ?? product.price ?? 0)
                .toDouble(),
            productImage: product.imgCover ?? '',
            productQuantityInCart: 1,
          );

    final cart = _withTotals(products);
    emit(
      state.copyWith(
        state: BaseState.success(cart),
        totalPrice: cart.totalPrice,
      ),
    );
    _scheduleSync(id);
  }

  void _changeQuantity(String id, int quantity) {
    if (id.isEmpty) return;

    final products = _productsCopy();
    if (!products.containsKey(id)) return;

    if (quantity <= 0) {
      products.remove(id);
    } else {
      products[id] = products[id]!.copyWith(productQuantityInCart: quantity);
    }

    final cart = _withTotals(products);
    emit(
      state.copyWith(
        state: BaseState.success(cart),
        totalPrice: cart.totalPrice,
      ),
    );
    _scheduleSync(id);
  }

  Future<void> flushPendingSyncs() async {
    for (final id in _pendingSync.keys.toList()) {
      _pendingSync.remove(id)?.cancel();
      await _sync(id);
    }
  }

  void _scheduleSync(String id) {
    _pendingSync[id]?.cancel();
    _pendingSync[id] = Timer(_debounce, () {
      _pendingSync.remove(id);
      _sync(id);
    });
  }

  Future<void> _sync(String id) async {
    final synced = _syncedQuantity[id] ?? 0;
    final current = _quantityOf(id);
    if (current == synced) return;

    final result = await _syncService.sync(
      productId: id,
      previousQuantity: synced,
      newQuantity: current,
    );
    switch (result) {
      case Success<void>():
        if (current == 0) {
          _syncedQuantity.remove(id);
        } else {
          _syncedQuantity[id] = current;
        }
      case Error<void>():
        final cart = _withTotals(_revertedProducts(id, synced));
        emit(
          state.copyWith(
            state: BaseState.success(cart),
            totalPrice: cart.totalPrice,
          ),
        );
        _notify(id, result.exception);
    }
  }

  CartEntity _currentCart() => state.state.data ?? CartEntity.empty();

  int _quantityOf(String id) =>
      _currentCart().cartProductsMap[id]?.productQuantityInCart ?? 0;

  Map<String, CartProductEntity> _productsCopy() =>
      Map.of(_currentCart().cartProductsMap);

  Map<String, CartProductEntity> _revertedProducts(String id, int quantity) {
    final products = _productsCopy();
    if (quantity <= 0) {
      products.remove(id);
    } else if (products.containsKey(id)) {
      products[id] = products[id]!.copyWith(productQuantityInCart: quantity);
    }
    return products;
  }

  CartEntity _withTotals(Map<String, CartProductEntity> products) {
    var total = 0.0;
    var count = 0;
    for (final p in products.values) {
      total += p.productPrice * p.productQuantityInCart;
      count += p.productQuantityInCart;
    }
    return _currentCart().copyWith(
      cartProductsMap: products,
      numOfCartItems: count,
      totalPrice: total,
    );
  }

  void _notify(String id, Exception? exception) {
    if (_notifications.isClosed) return;
    final message = exception is Failures
        ? exception.errorMessage
        : (exception?.toString() ?? 'Something went wrong');
    _notifications.add(
      CartSyncFailedNotification(productId: id, message: message),
    );
  }
}
