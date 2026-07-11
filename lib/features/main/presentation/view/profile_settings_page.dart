import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/core/values/app_font_style.dart';
import 'package:flowers_app/core/values/app_strings.dart';
import 'package:flowers_app/core/constants/app_urls.dart';
import 'package:flutter/material.dart';

class ProfileSettingsPage extends StatelessWidget {
  const ProfileSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: AppColors.shadowBox,
            ),
            child: Column(
              children: [
                _SettingsTile(
                  title: AppStrings.aboutUs,
                  trailing: const Icon(
                    Icons.keyboard_arrow_right,
                    color: AppColors.grayA6,
                  ),
                  onTap: () => AppUrls.openUrl(context, AppUrls.aboutUs),
                ),
                const Divider(height: 1, color: AppColors.grayEA),
                _SettingsTile(
                  title: AppStrings.termsAndConditions,
                  trailing: const Icon(
                    Icons.keyboard_arrow_right,
                    color: AppColors.grayA6,
                  ),
                  onTap: () => AppUrls.openUrl(context, AppUrls.termsAndConditions),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingsTile extends StatelessWidget {
  const _SettingsTile({
    required this.title,
    required this.trailing,
    required this.onTap,
  });

  final String title;
  final Widget trailing;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: AppFontStyle.light16(
                    context: context,
                  ).copyWith(color: AppColors.black0C),
                ),
              ),
              trailing,
            ],
          ),
        ),
      ),
    );
  }
}
