import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/core/values/app_font_style.dart';
import 'package:flutter/material.dart';

class CheckoutAppBar extends AppBar {
  CheckoutAppBar({
    super.key,
    required BuildContext context,
    required String title,
  }) : super(
    leading: InkWell(
      onTap: () => Navigator.of(context).pop(),
      child: const Icon(
        Icons.arrow_back_ios_new,
        size: 24,
        color: AppColors.black0C,
      ),
    ),
    title: Text(title),
    titleTextStyle: AppFontStyle.medium20(context: context).copyWith(color: AppColors.black0C),
    titleSpacing: -8,
    leadingWidth: 44,
    backgroundColor: AppColors.whiteF9,
    surfaceTintColor: AppColors.whiteF9,
    elevation: 0,
    scrolledUnderElevation: 0,
  );
}
