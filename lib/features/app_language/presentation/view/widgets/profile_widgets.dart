import 'package:flowers_app/core/values/app_assets.dart';
import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/core/values/app_font_style.dart';
import 'package:flowers_app/core/values/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage(AppAssets.imagesIcLauncherAndroid),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const Gap(16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Nour',
                style: AppFontStyle.semiBold18(context: context).copyWith(
                  color: AppColors.black,
                ),
              ),
              const Gap(8),
              SvgPicture.asset(AppAssets.iconsEditProfile, height: 16),
            ],
          ),
          const Gap(4),
          Text(
            'Nour_Mohamed@gmail.com',
            style: AppFontStyle.regular14(context: context).copyWith(
              color: AppColors.gray7D,
            ),
          ),
        ],
      ),
    );
  }
}

class ProfileMenuItem extends StatelessWidget {
  final String title;
  final String? icon;
  final bool isLogout;
  final VoidCallback onTap;

  const ProfileMenuItem({
    super.key,
    required this.title,
    this.icon,
    this.isLogout = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          children: [
            if (icon != null) ...[
              SvgPicture.asset(
                icon!,
                height: 20,
                colorFilter: const ColorFilter.mode(
                  AppColors.black35,
                  BlendMode.srcIn,
                ),
              ),
              const Gap(12),
            ],
            Expanded(
              child: Text(
                title,
                style: AppFontStyle.medium14(context: context).copyWith(
                  color: AppColors.black35,
                ),
              ),
            ),
            if (isLogout)
              Transform.flip(
                flipX: true,
                child: SvgPicture.asset(
                  AppAssets.iconsLogout,
                  height: 20,
                  colorFilter: const ColorFilter.mode(
                    AppColors.black35,
                    BlendMode.srcIn,
                  ),
                ),
              )
            else
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
}

class NotificationTile extends StatelessWidget {
  final bool isEnabled;
  final ValueChanged<bool> onChanged;

  const NotificationTile({
    super.key,
    required this.isEnabled,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => onChanged(!isEnabled),
            child: Container(
              width: 44,
              height: 24,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: isEnabled ? AppColors.primerColor : AppColors.grayCF,
              ),
              child: AnimatedAlign(
                duration: const Duration(milliseconds: 200),
                alignment: isEnabled ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  width: 20,
                  height: 20,
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
          ),
          const Gap(12),
          Expanded(
            child: Text(
              AppStrings.notification,
              style: AppFontStyle.medium14(context: context).copyWith(
                color: AppColors.black35,
              ),
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: AppColors.black5D,
          ),
        ],
      ),
    );
  }
}
