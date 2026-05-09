import 'package:flowers_app/core/widgets/custom_shimmer_container.dart';
import 'package:flutter/material.dart';

class ProductsShimmer extends StatelessWidget {
  const ProductsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade200, width: .5),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Image placeholder — same aspect ratio as _ProductImage
          AspectRatio(
            aspectRatio: 148 / 132,
            child: CustomShimmerContainer(
              height: 132,
              width: double.infinity,
              borderRadius: 6,
            ),
          ),
          const SizedBox(height: 8),
          // Title line
          CustomShimmerContainer(
            height: 12,
            width: double.infinity,
            borderRadius: 4,
          ),
          const SizedBox(height: 4),
          // Price row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomShimmerContainer(height: 14, width: 60, borderRadius: 4),
              const SizedBox(width: 4),
              CustomShimmerContainer(height: 12, width: 36, borderRadius: 4),
              const SizedBox(width: 4),
              CustomShimmerContainer(height: 12, width: 28, borderRadius: 4),
            ],
          ),
          const SizedBox(height: 8),
          // Add to cart button
          CustomShimmerContainer(
            height: 30,
            width: double.infinity,
            borderRadius: 100,
          ),
        ],
      ),
    );
  }
}
