import 'package:flutter/material.dart';
import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/core/values/app_font_style.dart';
import 'package:flowers_app/core/values/app_strings.dart';
import 'package:flowers_app/features/track_order/domain/entities/track_order_item_entity.dart';
import 'package:flowers_app/features/track_order/presentation/view/widgets/track_card.dart';
import 'package:flowers_app/features/track_order/presentation/view/widgets/track_item_row.dart';
import 'package:gap/gap.dart';

class TrackItemsCard extends StatelessWidget {
  const TrackItemsCard({super.key, required this.items});

  final List<TrackOrderItemEntity> items;

  @override
  Widget build(BuildContext context) {
    return TrackCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _Header(count: items.length),
          const Gap(16),
          ...List.generate(items.length, (index) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: index == items.length - 1 ? 0 : 16,
              ),
              child: TrackItemRow(item: items[index]),
            );
          }),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.shopping_cart_outlined,
          size: 24,
          color: AppColors.black0C,
        ),
        const Gap(8),
        Text(
          "$count ${AppStrings.items}",
          style: AppFontStyle.medium16(
            context: context,
          ).copyWith(color: AppColors.black0C),
        ),
      ],
    );
  }
}
