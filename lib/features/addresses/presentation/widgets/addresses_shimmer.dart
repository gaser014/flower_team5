import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/core/widgets/custom_shimmer_container.dart';
import 'package:flutter/material.dart';

/// Shimmer loading widget for Addresses
class AddressesShimmer extends StatelessWidget {
  const AddressesShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: 5,
      itemBuilder: (context, index) => const _ShimmerItem(),
    );
  }
}

/// Shimmer for "load more" state
class AddressesShimmerMore extends StatelessWidget {
  const AddressesShimmerMore({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: 3,
      itemBuilder: (context, index) => const _ShimmerItem(),
    );
  }
}

class _ShimmerItem extends StatelessWidget {
  const _ShimmerItem();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.whiteF9,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(83, 83, 83, 0.25),
            blurRadius: 2,
            offset: Offset.zero,
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  spacing: 4,
                  children: [
                    const CustomShimmerContainer(
                      width: 20,
                      height: 20,
                      borderRadius: 4,
                    ),
                    const CustomShimmerContainer(
                      width: 80,
                      height: 16,
                      borderRadius: 4,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const CustomShimmerContainer(
                  width: 140,
                  height: 14,
                  borderRadius: 4,
                ),
              ],
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CustomShimmerContainer(
                width: 24,
                height: 24,
                borderRadius: 4,
              ),
              const SizedBox(width: 4),
              const CustomShimmerContainer(
                width: 24,
                height: 24,
                borderRadius: 4,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
