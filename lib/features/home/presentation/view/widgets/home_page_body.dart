import 'package:flowers_app/core/values/app_strings.dart';
import 'package:flowers_app/features/home/presentation/view/widgets/best_seller_section.dart';
import 'package:flowers_app/features/home/presentation/view/widgets/category_list_section.dart';
import 'package:flowers_app/features/home/presentation/view/widgets/occasion_section.dart';
import 'package:flowers_app/features/home/presentation/view/widgets/section_header.dart';
import 'package:flowers_app/features/main/presentation/view_model/cubit/home_cubit.dart';
import 'package:flowers_app/features/main/presentation/view_model/cubit/home_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class HomePageBody extends StatelessWidget {
  const HomePageBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();
    return SafeArea(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SectionHeader(
              title: AppStrings.categories,
              onViewAllPressed: () =>
                  cubit.doIndented(ChangeBottomNavIndexEvent(1)),
            ),
            const CategoryListSection(),
            const Gap(16),
            const SectionHeader(title: AppStrings.bestSeller),
            const BestSellerSection(),
            const Gap(16),
            const SectionHeader(title: AppStrings.occasion),
            const OccasionSection(),
          ],
        ),
      ),
    );
  }
}
