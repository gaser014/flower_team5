import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/core/values/app_font_style.dart';
import 'package:flowers_app/core/widgets/custom_shimmer_container.dart';
import 'package:flutter/material.dart';

class FilterTab extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const FilterTab({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: !isSelected ? onTap : null,
      child: IntrinsicWidth(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 6,
          children: [
            _Label(label: label, isSelected: isSelected),
            Container(
              height: 3,
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primerColor : Colors.transparent,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(100),
                topRight: Radius.circular(100),
              ),
            ),
          ),
          ],
        ),
      ),
    );
  }
}

class _Label extends StatelessWidget {
  final String label;
  final bool isSelected;

  const _Label({required this.label, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: AppFontStyle.regular16().copyWith(
        color: isSelected ? AppColors.primerColor : AppColors.grayA6,
      ),
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
    );
  }
}

class FilterTabShimmer extends StatelessWidget {
  const FilterTabShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: IntrinsicWidth(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 6,
          children: [
            const CustomShimmerContainer(height: 24, width: 64),
            Container(
              height: 3,
            decoration: const BoxDecoration(
              color: AppColors.grayA6,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(100),
                topRight: Radius.circular(100),
              ),
            ),
          ),
          ],
        ),
      ),
    );
  }
}
