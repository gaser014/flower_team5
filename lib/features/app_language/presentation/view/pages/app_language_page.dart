import 'package:flowers_app/config/helper/enum/app_language_enum.dart';
import 'package:flowers_app/core/values/app_assets.dart';
import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/core/values/app_font_style.dart';
import 'package:flowers_app/core/values/app_strings.dart';
import 'package:flowers_app/features/app_language/presentation/view/widgets/language_bottom_sheet.dart';
import 'package:flowers_app/features/app_language/presentation/view/widgets/profile_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

import 'package:flowers_app/features/app_language/presentation/view_model/cubit/app_language_cubit.dart';
import 'package:flowers_app/features/app_language/presentation/view_model/cubit/app_language_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppLanguagePage extends StatefulWidget {
  const AppLanguagePage({super.key});

  @override
  State<AppLanguagePage> createState() => _AppLanguagePageState();
}

class _AppLanguagePageState extends State<AppLanguagePage> {
  bool isNotificationEnabled = true;

  void _showLanguageBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return LanguageBottomSheet(
          initialLanguage: AppLanguageEnum.fromLocale(context),
          onLanguageSelected: (newLanguage) {
            HomeCubit.get(context).changeLanguage(context, newLanguage.code);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteF9,
      appBar: _buildAppBar(context),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Gap(32),
            const ProfileHeader(),
            const Gap(32),
            _buildSettingsList(context),
            const Gap(32),
            _buildVersionInfo(context),
            const Gap(32),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.whiteF9,
      elevation: 0,
      title: Row(
        children: [
          SvgPicture.asset(AppAssets.iconsFlower, height: 24),
          const Gap(8),
          Text(
            AppStrings.appTitle,
            style: AppFontStyle.bold20(
              context: context,
            ).copyWith(color: AppColors.primerColor),
          ),
        ],
      ),
      actions: [_buildNotificationBadge(context)],
    );
  }

  Widget _buildNotificationBadge(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topRight,
        children: [
          SvgPicture.asset(
            AppAssets.iconsNotification,
            height: 24,
            colorFilter: const ColorFilter.mode(
              AppColors.black5D,
              BlendMode.srcIn,
            ),
          ),
          Positioned(
            right: -4,
            top: -4,
            child: Container(
              padding: const EdgeInsets.all(4),
              decoration: const BoxDecoration(
                color: AppColors.redCC,
                shape: BoxShape.circle,
              ),
              child: Text(
                '3',
                style: AppFontStyle.medium8(
                  context: context,
                ).copyWith(color: AppColors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsList(BuildContext context) {
    return Column(
      children: [
        Container(
          color: AppColors.white,
          child: Column(
            children: [
              ProfileMenuItem(
                title: AppStrings.myOrders,
                icon: AppAssets.iconsTransactionOrder,
                onTap: () {},
              ),
              ProfileMenuItem(
                title: AppStrings.savedAddresses,
                icon: AppAssets.iconsLocation,
                onTap: () {},
              ),
            ],
          ),
        ),
        const Divider(height: 1, thickness: 1, color: AppColors.grayEA),
        Container(
          color: AppColors.white,
          child: NotificationTile(
            isEnabled: isNotificationEnabled,
            onChanged: (val) => setState(() => isNotificationEnabled = val),
          ),
        ),
        const Divider(height: 1, thickness: 1, color: AppColors.grayEA),
        Container(
          color: AppColors.white,
          child: Column(
            children: [
              _buildLanguageTile(context),
              ProfileMenuItem(title: AppStrings.aboutUs, onTap: () {}),
              ProfileMenuItem(
                title: AppStrings.termsAndConditions,
                onTap: () {},
              ),
            ],
          ),
        ),
        const Divider(height: 1, thickness: 1, color: AppColors.grayEA),
        Container(
          color: AppColors.white,
          child: ProfileMenuItem(
            title: AppStrings.logout,
            icon: AppAssets.iconsLogout,
            isLogout: true,
            onTap: () {},
          ),
        ),
      ],
    );
  }

  Widget _buildLanguageTile(BuildContext context) {
    return InkWell(
      onTap: () => _showLanguageBottomSheet(context),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            SvgPicture.asset(
              AppAssets.iconsTranslateLang,
              height: 20,
              colorFilter: const ColorFilter.mode(
                AppColors.black35,
                BlendMode.srcIn,
              ),
            ),
            const Gap(12),
            Expanded(
              child: Text(
                AppStrings.language,
                style: AppFontStyle.medium14(
                  context: context,
                ).copyWith(color: AppColors.black35),
              ),
            ),
            BlocBuilder<HomeCubit, HomeStates>(
              builder: (context, state) {
                return Text(
                  AppLanguageEnum.fromLocale(context).text,
                  style: AppFontStyle.regular12(
                    context: context,
                  ).copyWith(color: AppColors.primerColor),
                );
              },
            ),
            const Gap(8),
            const Icon(
              Icons.arrow_forward_ios,
              size: 16,
              color: AppColors.black5D,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVersionInfo(BuildContext context) {
    return Text(
      'v 6.3.0 - (446)',
      style: AppFontStyle.regular12(
        context: context,
      ).copyWith(color: AppColors.grayA6),
    );
  }
}
