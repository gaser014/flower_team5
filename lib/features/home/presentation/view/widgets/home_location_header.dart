import 'package:flowers_app/core/values/app_assets.dart';
import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/core/values/app_font_style.dart';
import 'package:flowers_app/core/values/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class HomeLocationHeader extends StatelessWidget {
  const HomeLocationHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          SvgPicture.asset(
            AppAssets.iconsLocation,
            height: 20,
            width: 20,
            colorFilter: const ColorFilter.mode(
              AppColors.black32,
              BlendMode.srcIn,
            ),
          ),
          const Gap(8),
          Expanded(
            child: Text(
              '${AppStrings.deliverTo} 2XVP+XC - Sheikh Zayed',
              style: AppFontStyle.medium14(
                context: context,
              ).copyWith(color: AppColors.black32),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const Gap(4),
          SvgPicture.asset(
            AppAssets.iconsDownArrow,
            height: 10,
            width: 10,
            colorFilter: const ColorFilter.mode(
              AppColors.primerColor,
              BlendMode.srcIn,
            ),
          ),
        ],
      ),
    );
  }
}
