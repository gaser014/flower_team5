part of 'my_orders_cubit.dart';

class MyOrdersStates extends Equatable {
  final BaseState<List<OrderEntity>> ordersState;

  const MyOrdersStates({
    this.ordersState = const BaseState.initial(),
  });

  MyOrdersStates copyWith({
    BaseState<List<OrderEntity>>? ordersState,
  }) {
    return MyOrdersStates(
      ordersState: ordersState ?? this.ordersState,
    );
  }

  @override
  List<Object?> get props => [ordersState];
}
