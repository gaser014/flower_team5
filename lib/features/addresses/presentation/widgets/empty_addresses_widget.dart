import 'package:flowers_app/core/values/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/core/values/app_font_style.dart';

class EmptyAddressesWidget extends StatelessWidget {
  const EmptyAddressesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/icons/location.svg',
            height: 100,
            width: 100,
            colorFilter: const ColorFilter.mode(
              AppColors.grayA6,
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            AppStrings.noAddressesYet,
            style: AppFontStyle.medium18(
              context: context,
            ).copyWith(color: AppColors.gray7D),
          ),
          const SizedBox(height: 8),
          Text(
            AppStrings.addAddressToStart,
            style: AppFontStyle.regular14(
              context: context,
            ).copyWith(color: AppColors.gray7D),
          ),
        ],
      ),
    );
  }
}
