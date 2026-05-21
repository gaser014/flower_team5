import 'package:flowers_app/features/home/domain/entities/home_category_entity.dart';
import 'package:flowers_app/features/home/presentation/view/widgets/home_category_card.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CategoryListSection extends StatelessWidget {
  const CategoryListSection({super.key, required this.categories});

  final List<HomeCategoryEntity> categories;

  @override
  Widget build(BuildContext context) {
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
