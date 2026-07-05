import 'package:flowers_app/core/widgets/custom_shimmer_container.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class HomeShimmer extends StatelessWidget {
  const HomeShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _ShimmerSectionHeader(),
          const _ShimmerCategoryList(),
          const Gap(16),
          const _ShimmerSectionHeader(),
          const _ShimmerProductList(),
          const Gap(16),
          const _ShimmerSectionHeader(),
          const _ShimmerOccasionList(),
        ],
      ),
    );
  }
}

class _ShimmerSectionHeader extends StatelessWidget {
  const _ShimmerSectionHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomShimmerContainer(height: 20, width: 100),
          CustomShimmerContainer(height: 16, width: 60),
        ],
      ),
    );
  }
}

class _ShimmerCategoryList extends StatelessWidget {
  const _ShimmerCategoryList();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 110,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        separatorBuilder: (context, index) => const Gap(16),
        itemBuilder: (context, index) => Column(
          children: [
            CustomShimmerContainer(height: 80, width: 80, borderRadius: 100),
            const Gap(8),
            CustomShimmerContainer(height: 12, width: 60),
          ],
        ),
      ),
    );
  }
}

class _ShimmerProductList extends StatelessWidget {
  const _ShimmerProductList();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        separatorBuilder: (context, index) => const Gap(16),
        itemBuilder: (context, index) => CustomShimmerContainer(
          height: 250,
          width: 160,
          borderRadius: 16,
        ),
      ),
    );
  }
}

class _ShimmerOccasionList extends StatelessWidget {
  const _ShimmerOccasionList();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 220,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: 3,
        separatorBuilder: (context, index) => const Gap(16),
        itemBuilder: (context, index) => CustomShimmerContainer(
          height: 220,
          width: 160,
          borderRadius: 16,
        ),
      ),
    );
  }
}
