import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/core/values/app_font_style.dart';
import 'package:flowers_app/core/widgets/custom_cached_image.dart';
import 'package:flowers_app/features/home/presentation/view/widgets/occasion_section.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class HomeProductAndOccasionCard extends StatelessWidget {
  const HomeProductAndOccasionCard({
    super.key,
    required this.name,
    required this.cardType,
    required this.imageUrl,
    required this.onTap,
    this.price,
  });

  final String name;
  final String imageUrl;
  final num? price;
  final Function() onTap;

  final HomeCardType cardType;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 150,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomCachedImage(
              imagePath: imageUrl,
              height: 180,
              width: 150,
              fit: BoxFit.cover,
            ),
            const Gap(8),
            Text(
              name,
              style: AppFontStyle.regular16(
                context: context,
              ).copyWith(color: AppColors.black0C),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            if (cardType == HomeCardType.product)
              Text(
                '$price EGP',
                style: AppFontStyle.semiBold16(
                  context: context,
                ).copyWith(color: AppColors.black0C),
              ),
          ],
        ),
      ),
    );
  }
}
