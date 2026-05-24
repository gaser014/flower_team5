import 'package:flowers_app/core/values/app_assets.dart';
import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/core/values/app_font_style.dart';
import 'package:flowers_app/core/values/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class CartUpperPart extends StatelessWidget {
  final int itemsCount;
  final String address;

  const CartUpperPart({
    super.key,
    required this.itemsCount,
    this.address = '2XVP+XC - Sheikh Zayed.....',
  });

  @override
  Widget build(BuildContext context) {
    final canPop = context.canPop();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Row(
          children: [
            if (canPop)
              GestureDetector(
                onTap: () => context.pop(),
                child: SvgPicture.asset(
                  AppAssets.arrowBack,
                  width: 20,
                  height: 20,
                  colorFilter: const ColorFilter.mode(
                    AppColors.black0C,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            if (canPop) const SizedBox(width: 8),
            Text(
              AppStrings.cartTitle,
              style: AppFontStyle.medium20(
                context: context,
              ).copyWith(color: AppColors.black0C),
            ),
            const SizedBox(width: 4),
            Text(
              '($itemsCount items)',
              style: AppFontStyle.medium20(
                context: context,
              ).copyWith(color: AppColors.gray53),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              SvgPicture.asset(
                AppAssets.iconsLocation,
                width: 24,
                height: 24,
                colorFilter: const ColorFilter.mode(
                  AppColors.gray53,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                AppStrings.deliverTo,
                style: AppFontStyle.medium16(
                  context: context,
                ).copyWith(color: AppColors.gray53),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  address,
                  style: AppFontStyle.medium16(
                    context: context,
                  ).copyWith(color: AppColors.black0C),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const Icon(
                Icons.keyboard_arrow_down_rounded,
                size: 24,
                color: AppColors.gray53,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
