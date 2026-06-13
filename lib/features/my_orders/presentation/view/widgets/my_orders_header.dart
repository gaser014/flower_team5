import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/core/values/app_font_style.dart';
import 'package:flowers_app/core/values/app_strings.dart';
import 'package:flutter/material.dart';

class MyOrdersHeader extends StatelessWidget {
  const MyOrdersHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: const Icon(
              Icons.arrow_back_ios,
              color: AppColors.black0C,
              size: 24,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            AppStrings.myOrders,
            style: AppFontStyle.medium20(context: context)
                .copyWith(color: AppColors.black0C),
          ),
        ],
      ),
    );
  }
}
