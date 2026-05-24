import 'package:equatable/equatable.dart';
import 'package:flowers_app/config/base_state/base_state.dart';
import 'package:flowers_app/features/cart/domain/entities/cart_entity.dart';

class CartStates extends Equatable {
  final BaseState<CartEntity> state;
  final double totalPrice;

  const CartStates({required this.state, required this.totalPrice});

  factory CartStates.initial() =>
      const CartStates(state: BaseState<CartEntity>.initial(), totalPrice: 0);

  CartStates copyWith({BaseState<CartEntity>? state, double? totalPrice}) {
    return CartStates(
      state: state ?? this.state,
      totalPrice: totalPrice ?? this.totalPrice,
    );
  }

  int quantityOf(String productId) =>
      state.data?.cartProductsMap[productId]?.productQuantityInCart ?? 0;

  @override
  List<Object?> get props => [state, totalPrice];
}
