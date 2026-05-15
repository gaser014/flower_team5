import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/core/values/app_font_style.dart';
import 'package:flowers_app/core/values/app_strings.dart';
import 'package:flowers_app/core/widgets/custom_cached_image.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ProductCard extends StatelessWidget {
  final dynamic product; // Replace with ProductEntity when available

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Product Image
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
              child: CustomCachedImage(
                imagePath: '', // product.imageUrl
                height: double.infinity,
                width: double.infinity,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Product Name
                Text(
                  'Red roses', // product.name
                  style: AppFontStyle.medium14(
                    context: context,
                  ).copyWith(color: AppColors.black),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const Gap(4),
                // Price Row
                Row(
                  children: [
                    Text(
                      'EGP 600', // product.price
                      style: AppFontStyle.bold14(
                        context: context,
                      ).copyWith(color: AppColors.black),
                    ),
                    const Gap(8),
                    Text(
                      '800', // product.oldPrice
                      style: AppFontStyle.regular12(context: context).copyWith(
                        color: AppColors.grayA6,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    const Gap(8),
                    Text(
                      '20%', // product.discount
                      style: AppFontStyle.bold12(
                        context: context,
                      ).copyWith(color: Colors.green),
                    ),
                  ],
                ),
                const Gap(8),
                // Add to Cart Button
                SizedBox(
                  width: double.infinity,
                  height: 32,
                  child: ElevatedButton(
                    onPressed: () {
                      // Add to cart logic
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primerColor,
                      foregroundColor: AppColors.white,
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.shopping_cart_outlined, size: 16),
                        const Gap(4),
                        Text(
                          AppStrings.addToCart,
                          style: AppFontStyle.bold12(context: context),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
