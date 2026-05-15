import 'package:flowers_app/core/routes/routes.dart';
import 'package:flowers_app/features/home/presentation/view/widgets/home_product_and_occasion_card.dart';
import 'package:flowers_app/features/home/presentation/view/widgets/occasion_section.dart';
import 'package:flowers_app/features/products/domain/entities/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class BestSellerSection extends StatelessWidget {
  const BestSellerSection({super.key, required this.products});

  final List<ProductEntity> products;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        separatorBuilder: (context, index) => const Gap(16),
        itemBuilder: (context, index) {
          final product = products[index];
          return HomeProductAndOccasionCard(
            name: product.title ?? '',
            imageUrl: product.imgCover ?? '',
            cardType: HomeCardType.product,
            price: product.price,
            onTap: () {
              context.push(Routes.productDetails, extra: product);
            },
          );
        },
      ),
    );
  }
}
