import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/core/values/app_font_style.dart';
import 'package:flowers_app/core/values/app_strings.dart';
import 'package:flowers_app/features/my_orders/presentation/view/widgets/order_item_track_button.dart';
import 'package:flutter/material.dart';

class OrderItemDetails extends StatelessWidget {
  final String title;
  final int price;
  final String orderNumber;

  const OrderItemDetails({
    super.key,
    required this.title,
    required this.price,
    required this.orderNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppFontStyle.regular12(context: context)
              .copyWith(color: AppColors.black0C),
        ),
        const SizedBox(height: 4),
        Text(
          'EGP $price',
          style: AppFontStyle.medium14(context: context)
              .copyWith(color: AppColors.black0C),
        ),
        const SizedBox(height: 4),
        Text(
          '${AppStrings.orderNumber} $orderNumber',
          style: AppFontStyle.regular12(context: context)
              .copyWith(color: AppColors.gray53),
        ),
        const SizedBox(height: 16),
        const OrderItemTrackButton(),
      ],
    );
  }
}
