import 'package:flowers_app/features/home/presentation/view/widgets/home_product_and_occasion_card.dart';
import 'package:flowers_app/features/home/presentation/view/widgets/occasion_section.dart';
import 'package:flutter/material.dart';

import 'package:gap/gap.dart';

class ProductModel {
  final String name;
  final num? price;
  final String imageUrl;

  ProductModel({
    required this.name,
    required this.price,
    required this.imageUrl,
  });
}

class BestSellerSection extends StatelessWidget {
  const BestSellerSection({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ProductModel> products = [
      ProductModel(
        name: 'Sunny',
        price: 600,
        imageUrl:
            'https://images.unsplash.com/photo-1526047932273-341f2a7631f9?q=80&w=1000&auto=format&fit=crop',
      ),
      ProductModel(
        name: 'Red roses',
        price: 1000,
        imageUrl:
            'https://images.unsplash.com/photo-1562690868-60bbe7293e94?q=80&w=1000&auto=format&fit=crop',
      ),
      ProductModel(
        name: 'Spring vase',
        price: 1200,
        imageUrl:
            'https://images.unsplash.com/photo-1494972308255-02058699310a?q=80&w=1000&auto=format&fit=crop',
      ),
    ];

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
            name: product.name,
            imageUrl: product.imageUrl,
            cardType: HomeCardType.product,
            price: product.price,
            onTap: () {},
          );
        },
      ),
    );
  }
}
