import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/core/values/app_font_style.dart';
import 'package:flowers_app/core/values/app_strings.dart';
import 'package:flutter/material.dart';

class CheckoutDeliveryTime extends StatelessWidget {
  const CheckoutDeliveryTime({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: AppColors.whiteF9,
      child: Column(
        spacing: 16,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.deliveryTime,
            style: AppFontStyle.medium18(
              context: context,
            ).copyWith(color: AppColors.black0C),
          ),
          Row(
            spacing: 4,
            children: [
              const Icon(Icons.access_time, size: 24, color: AppColors.black0C),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: '${AppStrings.instant}, ',
                      style: AppFontStyle.medium14(
                        context: context,
                      ).copyWith(color: AppColors.black0C),
                    ),
                    TextSpan(
                      text: '${AppStrings.arriveBy} 03 Sep 2024, 11:00 AM',
                      style: AppFontStyle.medium14(
                        context: context,
                      ).copyWith(color: AppColors.green0C),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
