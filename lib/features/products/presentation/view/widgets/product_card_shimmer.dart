import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/core/widgets/custom_shimmer_container.dart';
import 'package:flutter/material.dart';

class ProductCardShimmer extends StatelessWidget {
  const ProductCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.gray53, width: .5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Image shimmer
          const AspectRatio(
            aspectRatio: 148 / 132,
            child: CustomShimmerContainer(
              height: double.infinity,
              width: double.infinity,
              borderRadius: 8,
            ),
          ),
          const SizedBox(height: 8),
          
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Title shimmer
                const CustomShimmerContainer(
                  height: 14,
                  width: 80,
                  borderRadius: 4,
                ),
                const SizedBox(height: 8),
                // Price shimmer
                const CustomShimmerContainer(
                  height: 16,
                  width: 100,
                  borderRadius: 4,
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          
          // Button shimmer
          const CustomShimmerContainer(
            height: 32,
            width: double.infinity,
            borderRadius: 100,
          ),
        ],
      ),
    );
  }
}
