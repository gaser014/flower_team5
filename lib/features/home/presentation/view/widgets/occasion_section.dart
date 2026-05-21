import 'package:flowers_app/features/home/domain/entities/home_occasion_entity.dart';
import 'package:flowers_app/features/home/presentation/view/widgets/home_product_and_occasion_card.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

enum HomeCardType { product, occasion }

class OccasionSection extends StatelessWidget {
  const OccasionSection({super.key, required this.occasions});

  final List<HomeOccasionEntity> occasions;

  @override
  Widget build(BuildContext context) {
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
            name: occasion.name ?? '',
            imageUrl: occasion.image ?? '',
            cardType: HomeCardType.occasion,
            onTap: () {},
          );
        },
      ),
    );
  }
}
