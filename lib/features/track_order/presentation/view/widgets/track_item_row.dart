import 'package:flutter/material.dart';
import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/core/values/app_font_style.dart';
import 'package:flowers_app/core/values/app_strings.dart';
import 'package:flowers_app/core/widgets/custom_cached_image.dart';
import 'package:flowers_app/features/track_order/domain/entities/track_order_item_entity.dart';
import 'package:gap/gap.dart';

class TrackItemRow extends StatelessWidget {
  const TrackItemRow({super.key, required this.item});

  final TrackOrderItemEntity item;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _Thumbnail(image: item.image),
        const Gap(8),
        Expanded(child: _NameAndDescription(item: item)),
        const Gap(8),
        Text(
          "${AppStrings.egp} ${item.price}",
          style: AppFontStyle.semiBold14(
            context: context,
          ).copyWith(color: AppColors.black0C),
        ),
      ],
    );
  }
}

class _Thumbnail extends StatelessWidget {
  const _Thumbnail({required this.image});

  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 57,
      height: 60,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.pinkF9,
        borderRadius: BorderRadius.circular(8),
      ),
      child: image.isEmpty
          ? const Icon(Icons.local_florist, color: AppColors.primerColor)
          : CustomCachedImage(imagePath: image, fit: BoxFit.cover),
    );
  }
}

class _NameAndDescription extends StatelessWidget {
  const _NameAndDescription({required this.item});

  final TrackOrderItemEntity item;

  @override
  Widget build(BuildContext context) {
    final secondary = item.description.isNotEmpty
        ? item.description
        : "x${item.quantity}";
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          item.title,
          style: AppFontStyle.medium16(
            context: context,
          ).copyWith(color: AppColors.black0C),
          overflow: TextOverflow.ellipsis,
        ),
        const Gap(4),
        Text(
          secondary,
          style: AppFontStyle.regular13(
            context: context,
          ).copyWith(color: AppColors.gray53),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
