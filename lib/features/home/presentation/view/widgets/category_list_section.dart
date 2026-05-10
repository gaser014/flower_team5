import 'package:flowers_app/core/values/app_assets.dart';
import 'package:flowers_app/core/values/app_strings.dart';
import 'package:flowers_app/features/home/presentation/view/widgets/category_card.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CategoryItemModel {
  final String title;
  final String icon;

  CategoryItemModel({required this.title, required this.icon});
}

class CategoryListSection extends StatelessWidget {
  const CategoryListSection({super.key});

  @override
  Widget build(BuildContext context) {
    final List<CategoryItemModel> categories = [
      CategoryItemModel(title: AppStrings.flowers, icon: AppAssets.iconsFlower),
      CategoryItemModel(title: AppStrings.gift, icon: AppAssets.iconsAddImage),
      CategoryItemModel(title: AppStrings.card, icon: AppAssets.iconsCalendar),
      CategoryItemModel(
        title: AppStrings.jewellery,
        icon: AppAssets.iconsProfile,
      ),
      CategoryItemModel(title: AppStrings.flowers, icon: AppAssets.iconsFlower),
    ];

    return SizedBox(
      height: 110,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (context, index) => const Gap(16),
        itemBuilder: (context, index) {
          final category = categories[index];
          return CategoryCard(category: category);
        },
      ),
    );
  }
}
