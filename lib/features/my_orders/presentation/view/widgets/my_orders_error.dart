import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/core/values/app_font_style.dart';
import 'package:flowers_app/core/values/app_strings.dart';
import 'package:flutter/material.dart';

class MyOrdersError extends StatelessWidget {
  final String? message;

  const MyOrdersError({super.key, this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        message ?? AppStrings.somethingWentWrong,
        style: AppFontStyle.regular16(context: context)
            .copyWith(color: AppColors.gray7D),
      ),
    );
  }
}
