import 'package:flowers_app/core/routes/routes.dart';
import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/features/my_orders/domain/entities/order_entity.dart';
import 'package:flowers_app/features/my_orders/presentation/view/widgets/order_item_details.dart';
import 'package:flowers_app/features/my_orders/presentation/view/widgets/order_item_image.dart';
import 'package:flowers_app/features/order_tracking/domain/entities/order_tracking_args.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OrderItemCard extends StatelessWidget {
  final OrderEntity order;

  const OrderItemCard({super.key, required this.order});

  String _firstImage() {
    if (order.orderItems == null || order.orderItems!.isEmpty) return '';
    return order.orderItems!.first.product?.imgCover ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(Routes.track, extra: order.id ?? ''),
      child: Container(
        padding: const EdgeInsets.fromLTRB(8, 8, 16, 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.gray53, width: 0.5),
        ),
        child: Row(
          children: [
            OrderItemImage(imageUrl: _firstImage()),
            const SizedBox(width: 16),
            Expanded(
              child: OrderItemDetails(
                order: order,
                onPressed: () => context.push(
                  Routes.orderTracking,
                  extra: OrderTrackingArgs(
                    orderNumber: order.orderNumber ?? '',
                    orderId: order.id ?? '',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
