import 'package:cached_network_image/cached_network_image.dart';
import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/core/values/app_font_style.dart';
import 'package:flowers_app/features/home/presentation/view/widgets/category_list_section.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({super.key, required this.category});

  final CategoryItemModel category;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 70,
          height: 70,
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: AppColors.pinkF9,
            shape: BoxShape.circle,
          ),
          child: CachedNetworkImage(imageUrl: category.icon),
        ),
        const Gap(8),
        Text(
          category.title,
          style: AppFontStyle.medium14(
            context: context,
          ).copyWith(color: AppColors.black32),
        ),
      ],
    );
  }
}
