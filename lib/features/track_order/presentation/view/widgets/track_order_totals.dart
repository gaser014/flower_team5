import 'package:flutter/material.dart';
import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/core/values/app_font_style.dart';
import 'package:flowers_app/core/values/app_strings.dart';
import 'package:gap/gap.dart';

class TrackOrderTotals extends StatelessWidget {
  const TrackOrderTotals({
    super.key,
    required this.subTotal,
    required this.deliveryFee,
    required this.total,
  });

  final num subTotal;
  final num deliveryFee;
  final num total;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _Line(label: AppStrings.subTotal, value: subTotal),
        const Gap(8),
        _Line(label: AppStrings.deliveryFee, value: deliveryFee),
        const Gap(16),
        const Divider(height: 1, color: AppColors.grayCF),
        const Gap(16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppStrings.totalPrice,
              style: AppFontStyle.medium18(
                context: context,
              ).copyWith(color: AppColors.black0C),
            ),
            Text(
              "$total ${AppStrings.egp}",
              style: AppFontStyle.medium18(
                context: context,
              ).copyWith(color: AppColors.black0C),
            ),
          ],
        ),
      ],
    );
  }
}

class _Line extends StatelessWidget {
  const _Line({required this.label, required this.value});

  final String label;
  final num value;

  @override
  Widget build(BuildContext context) {
    final style = AppFontStyle.regular16(
      context: context,
    ).copyWith(color: AppColors.gray53);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: style),
        Text("$value ${AppStrings.egp}", style: style),
      ],
    );
  }
}
