import 'package:flowers_app/core/values/app_strings.dart';
import 'package:flowers_app/features/home/presentation/view/widgets/best_seller_section.dart';
import 'package:flowers_app/features/home/presentation/view/widgets/category_list_section.dart';
import 'package:flowers_app/features/home/presentation/view/widgets/occasion_section.dart';
import 'package:flowers_app/features/home/presentation/view/widgets/section_header.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class HomePageBody extends StatelessWidget {
  const HomePageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader(title: AppStrings.categories),
            CategoryListSection(),
            Gap(16),
            SectionHeader(title: AppStrings.bestSeller),
            BestSellerSection(),
            Gap(16),
            SectionHeader(title: AppStrings.occasion),
            OccasionSection(),
          ],
        ),
      ),
    );
  }
}
