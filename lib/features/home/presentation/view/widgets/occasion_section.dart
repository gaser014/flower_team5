import 'package:flowers_app/core/values/app_strings.dart';
import 'package:flowers_app/features/home/presentation/view/widgets/home_product_and_occasion_card.dart';
import 'package:flutter/material.dart';

import 'package:gap/gap.dart';

class OccasionModel {
  final String title;
  final String imageUrl;

  OccasionModel({required this.title, required this.imageUrl});
}

enum HomeCardType { product, occasion }

class OccasionSection extends StatelessWidget {
  const OccasionSection({super.key});

  @override
  Widget build(BuildContext context) {
    final List<OccasionModel> occasions = [
      OccasionModel(
        title: AppStrings.wedding,
        imageUrl:
            'https://images.unsplash.com/photo-1519741497674-611481863552?q=80&w=1000&auto=format&fit=crop',
      ),
      OccasionModel(
        title: AppStrings.birthday,
        imageUrl:
            'https://images.unsplash.com/photo-1464349095431-e9a21285b5f3?q=80&w=1000&auto=format&fit=crop',
      ),
      OccasionModel(
        title: AppStrings.graduation,
        imageUrl:
            'https://images.unsplash.com/photo-1523050854058-8df90110c9f1?q=80&w=1000&auto=format&fit=crop',
      ),
    ];

    return SizedBox(
      height: 220,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: occasions.length,
        separatorBuilder: (context, index) => const Gap(16),
        itemBuilder: (context, index) {
          final occasion = occasions[index];
          return HomeProductAndOccasionCard(
            name: occasion.title,
            imageUrl: occasion.imageUrl,
            cardType: HomeCardType.occasion,
            onTap: () {},
          );
        },
      ),
    );
  }
}
