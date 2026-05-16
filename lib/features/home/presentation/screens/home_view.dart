import 'package:flowers_app/core/values/app_assets.dart';
import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/core/values/app_font_style.dart';
import 'package:flowers_app/core/values/app_strings.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(context),
            const Expanded(
              child: SingleChildScrollView(child: Column(children: [
                  ],
                )),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        children: [
          Row(
            children: [
              // Flowery Logo & Name
              Row(
                children: [
                  SvgPicture.asset(AppAssets.iconsFlower, height: 32),
                  const Gap(4),
                   Text(
                    AppStrings.appTitle,
                    style: AppFontStyle.bold20(
                      context: context,
                    ).copyWith(color: AppColors.primerColor),
                  ),
                ],
              ),
              const Gap(12),
              // Search Bar
              Expanded(
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppColors.whiteF9,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.grayEA),
                  ),
                  child: Row(
                    children: [
                      const Gap(12),
                      SvgPicture.asset(
                        AppAssets.iconsSearch,
                        colorFilter: const ColorFilter.mode(
                          AppColors.grayA6,
                          BlendMode.srcIn,
                        ),
                      ),
                      const Gap(8),
                      Text(
                        AppStrings.search,
                        style: AppFontStyle.regular14(
                          context: context,
                        ).copyWith(color: AppColors.grayA6),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const Gap(12),
        ],
      ),
    );
  }
}
