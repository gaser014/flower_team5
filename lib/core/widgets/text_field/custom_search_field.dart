import 'package:flowers_app/core/values/app_assets.dart';
import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/core/values/app_font_style.dart';
import 'package:flowers_app/core/values/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomSearchField extends StatelessWidget {
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onClear;
  final VoidCallback? onTap;
  final String? hintText;
  final bool autofocus;
  final bool readOnly;

  const CustomSearchField({
    super.key,
    this.controller,
    this.onChanged,
    this.onClear,
    this.onTap,
    this.hintText,
    this.autofocus = false,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteF9,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.grayA6, width: 0.5),
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        onTap: onTap,
        autofocus: autofocus,
        readOnly: readOnly,
        style: AppFontStyle.regular14(context: context),
        decoration: InputDecoration(
          hintText: hintText ?? AppStrings.search,
          hintStyle: AppFontStyle.regular14(context: context).copyWith(
            color: AppColors.grayA6,
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(12.0),
            child: SvgPicture.asset(
              AppAssets.iconsSearch,
              width: 20,
              height: 20,
              colorFilter: const ColorFilter.mode(
                AppColors.grayA6,
                BlendMode.srcIn,
              ),
            ),
          ),
          suffixIcon: controller?.text.isNotEmpty ?? false
              ? IconButton(
                  icon: const Icon(Icons.cancel, color: AppColors.grayA6),
                  onPressed: onClear,
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 12),
        ),
      ),
    );
  }
}
