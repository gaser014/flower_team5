import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/core/values/app_font_style.dart';
import 'package:flowers_app/core/values/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileSettingsPage extends StatelessWidget {
  static final Uri _aboutUsUrl = Uri.parse(
    'https://elevate-flutter-team.github.io/flower_app_web_views/about.html',
  );
  static final Uri _termsAndConditionsUrl = Uri.parse(
    'https://elevate-flutter-team.github.io/flower_app_web_views/terms.html',
  );

  const ProfileSettingsPage({super.key});

  Future<void> _openUrl(BuildContext context, Uri url) async {
    if (!await canLaunchUrl(url) ||
        !await launchUrl(url, mode: LaunchMode.platformDefault)) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Unable to open the page.')));
    }
  }

  Widget _buildTile({
    required BuildContext context,
    required String title,
    required Widget trailing,
    required VoidCallback onTap,
  }) {
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
                _buildTile(
                  context: context,
                  title: AppStrings.aboutUs,
                  trailing: const Icon(
                    Icons.keyboard_arrow_right,
                    color: AppColors.grayA6,
                  ),
                  onTap: () async {
                    await _openUrl(context, _aboutUsUrl);
                  },
                ),
                const Divider(height: 1, color: AppColors.grayEA),
                _buildTile(
                  context: context,
                  title: AppStrings.termsAndConditions,
                  trailing: const Icon(
                    Icons.keyboard_arrow_right,
                    color: AppColors.grayA6,
                  ),
                  onTap: () async {
                    await _openUrl(context, _termsAndConditionsUrl);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
