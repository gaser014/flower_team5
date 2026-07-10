import 'package:flowers_app/core/values/app_assets.dart';
import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/core/values/app_font_style.dart';
import 'package:flowers_app/core/values/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CartEmptyWidget extends StatelessWidget {
  const CartEmptyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(AppAssets.emptyCartIcon, width: 160, height: 160),
          const SizedBox(height: 12),
          Text(
            AppStrings.emptyCart,
            textAlign: TextAlign.center,
            style: AppFontStyle.medium18(
              context: context,
            ).copyWith(color: AppColors.primerColor),
          ),
        ],
      ),
    );
  }
}
