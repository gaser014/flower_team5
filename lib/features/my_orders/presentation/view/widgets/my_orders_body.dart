import 'package:flowers_app/core/values/app_strings.dart';
import 'package:flowers_app/features/my_orders/domain/entities/order_entity.dart';
import 'package:flowers_app/features/my_orders/presentation/view/widgets/my_orders_error.dart';
import 'package:flowers_app/features/my_orders/presentation/view/widgets/my_orders_loading.dart';
import 'package:flowers_app/features/my_orders/presentation/view/widgets/my_orders_order_list.dart';
import 'package:flowers_app/features/my_orders/presentation/view/widgets/my_orders_tab_bar.dart';
import 'package:flowers_app/features/my_orders/presentation/view_model/cubit/my_orders_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyOrdersPageBody extends StatelessWidget {
  const MyOrdersPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyOrdersCubit, MyOrdersStates>(
      builder: (context, state) {
        if (state.ordersState.isLoading) return const MyOrdersLoading();
        if (state.ordersState.isError) {
          return MyOrdersError(
            message: state.ordersState.exception?.toString(),
          );
        }
        return _buildTabs(state.ordersState.data ?? []);
      },
    );
  }

  Widget _buildTabs(List<OrderEntity> orders) {
    final active = orders.where((o) => o.isDelivered == false).toList();
    final completed = orders.where((o) => o.isDelivered == true).toList();

    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          const MyOrdersTabBar(),
          Expanded(
            child: TabBarView(
              children: [
                MyOrdersOrderList(
                  orders: active,
                  isEmptyMessage: AppStrings.noActiveOrders,
                ),
                MyOrdersOrderList(
                  orders: completed,
                  isEmptyMessage: AppStrings.noCompletedOrders,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
