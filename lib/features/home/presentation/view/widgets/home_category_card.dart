import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/core/values/app_font_style.dart';
import 'package:flowers_app/core/widgets/custom_cached_image.dart';
import 'package:flowers_app/features/home/domain/entities/home_category_entity.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key, required this.category});

  final HomeCategoryEntity category;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 70,
          height: 70,
          padding: const EdgeInsets.all(16),
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(
            color: AppColors.pinkF9,
            shape: BoxShape.circle,
          ),
          child: CustomCachedImage(
            imagePath: category.image ?? '',
            fit: BoxFit.contain,
          ),
        ),
        const Gap(8),
        Text(
          category.name ?? '',
          style: AppFontStyle.medium14(
            context: context,
          ).copyWith(color: AppColors.black32),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
