import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/core/values/app_font_style.dart';
import 'package:flowers_app/core/values/app_strings.dart';
import 'package:flutter/material.dart';

class EmptyProductsWidget extends StatelessWidget {
  const EmptyProductsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inbox_outlined,
            size: 80,
            color: AppColors.grayA6,
          ),
          const SizedBox(height:16),
          Text(
       AppStrings.noProductsFound,
            style: AppFontStyle.medium18().copyWith(color: AppColors.gray53),
          ),
          const SizedBox(height: 8),
          Text(
            AppStrings.tryAgain,
            style: AppFontStyle.regular14().copyWith(color: AppColors.gray53),
          ),
        ],
      ),
    );
  }
}
