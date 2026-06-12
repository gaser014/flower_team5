import 'package:flowers_app/core/localization_constants/address_constants.dart';
import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/core/values/app_font_style.dart';
import 'package:flutter/material.dart';

class EmptyAddressesWidget extends StatelessWidget {
  const EmptyAddressesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.location_off_outlined,
            size: 100,
            color: AppColors.grayA6,
          ),
          const SizedBox(height: 24),
          Text(
            context.noAddressesYet,
            style: AppFontStyle.medium18(
              context: context,
            ).copyWith(color: AppColors.gray7D),
          ),
          const SizedBox(height: 8),
          Text(
            context.addAddressToStart,
            style: AppFontStyle.regular14(
              context: context,
            ).copyWith(color: AppColors.gray7D),
          ),
        ],
      ),
    );
  }
}
