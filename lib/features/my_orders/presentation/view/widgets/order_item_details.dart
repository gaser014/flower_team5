import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/core/values/app_font_style.dart';
import 'package:flowers_app/core/values/app_strings.dart';
import 'package:flowers_app/features/my_orders/domain/entities/order_entity.dart';
import 'package:flowers_app/features/my_orders/presentation/view/widgets/order_item_track_button.dart';
import 'package:flutter/material.dart';

class OrderItemDetails extends StatelessWidget {
  final OrderEntity order;
  final VoidCallback onPressed;

  const OrderItemDetails({
    super.key,
    required this.onPressed,
    required this.order,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          order.orderItems?.first.product?.title ?? '',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppFontStyle.regular12(
            context: context,
          ).copyWith(color: AppColors.black0C),
        ),
        const SizedBox(height: 4),
        Text(
          'EGP ${order.totalPrice?.toInt() ?? 0}',
          style: AppFontStyle.medium14(
            context: context,
          ).copyWith(color: AppColors.black0C),
        ),
        const SizedBox(height: 4),
        Text(
          '${AppStrings.orderNumber} ${order.orderNumber ?? ''}',
          style: AppFontStyle.regular12(
            context: context,
          ).copyWith(color: AppColors.gray53),
        ),
        if (order.isDelivered == false) ...[
          const SizedBox(height: 16),
          OrderItemTrackButton(onPressed: onPressed),
        ],
      ],
    );
  }
}
