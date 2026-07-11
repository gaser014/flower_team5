import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/core/values/app_font_style.dart';
import 'package:flowers_app/core/values/app_strings.dart';
import 'package:flutter/material.dart';

class OrderItemTrackButton extends StatelessWidget {
  final VoidCallback? onPressed;
  const OrderItemTrackButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 30,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primerColor,
          foregroundColor: AppColors.whiteF9,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          padding: EdgeInsets.zero,
        ),
        child: Text(
          AppStrings.trackOrder,
          style: AppFontStyle.medium13(
            context: context,
          ).copyWith(color: AppColors.whiteF9),
        ),
      ),
    );
  }
}
