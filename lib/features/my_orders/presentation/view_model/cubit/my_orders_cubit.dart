import 'package:equatable/equatable.dart';
import 'package:flowers_app/config/base_state/base_state.dart';
import 'package:flowers_app/features/my_orders/domain/entities/order_entity.dart';
import 'package:flowers_app/features/my_orders/domain/use_cases/get_my_orders_use_case.dart';
import 'package:flowers_app/features/my_orders/presentation/view_model/cubit/my_orders_events.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'my_orders_states.dart';

@injectable
class MyOrdersCubit extends Cubit<MyOrdersStates> {
  final GetMyOrdersUseCase _getMyOrdersUseCase;

  MyOrdersCubit(this._getMyOrdersUseCase) : super(const MyOrdersStates());

  Future<void> doIntent(MyOrdersEvents event) async {
    switch (event) {
      case GetOrdersEvent():
        await _getOrders();
    }
  }

  Future<void> _getOrders() async {
    emit(state.copyWith(ordersState: BaseState.loading()));
    final result = await _getMyOrdersUseCase.call();
    result.when(
      success: (orders) {
        emit(state.copyWith(ordersState: BaseState.success(orders ?? [])));
      },
      error: (exception) {
        emit(state.copyWith(ordersState: BaseState.error(exception)));
      },
    );
  }
}
