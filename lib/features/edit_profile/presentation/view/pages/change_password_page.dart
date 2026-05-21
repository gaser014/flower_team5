import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/core/values/app_font_style.dart';
import 'package:flowers_app/core/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteF9,
      appBar: const CustomAppBar(
        title: 'Change password',
        showBackButton: true,
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.lock_reset_outlined,
                  size: 80,
                  color: AppColors.primerColor,
                ),
                const SizedBox(height: 16),
                Text(
                  "Change Password Screen",
                  style: AppFontStyle.medium20(context: context).copyWith(
                    color: AppColors.black0C,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "This is a placeholder for changing your password.",
                  style: AppFontStyle.regular14().copyWith(
                    color: AppColors.gray53,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
