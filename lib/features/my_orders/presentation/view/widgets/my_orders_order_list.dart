import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/features/my_orders/domain/entities/order_entity.dart';
import 'package:flowers_app/features/my_orders/presentation/view/widgets/order_item_card.dart';
import 'package:flutter/material.dart';

class MyOrdersOrderList extends StatelessWidget {
  final List<OrderEntity> orders;
  final String isEmptyMessage;

  const MyOrdersOrderList({
    super.key,
    required this.orders,
    required this.isEmptyMessage,
  });

  @override
  Widget build(BuildContext context) {
    if (orders.isEmpty) {
      return Center(
        child: Text(
          isEmptyMessage,
          style: const TextStyle(color: AppColors.gray7D, fontSize: 16),
        ),
      );
    }
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: orders.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: OrderItemCard(order: orders[index]),
      ),
    );
  }
}
