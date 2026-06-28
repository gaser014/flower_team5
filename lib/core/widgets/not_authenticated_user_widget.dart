import 'package:flowers_app/core/routes/routes.dart';
import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/core/values/app_font_style.dart';
import 'package:flowers_app/core/values/app_strings.dart';
import 'package:flowers_app/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class NotAuthenticatedUserWidget extends StatelessWidget {
  const NotAuthenticatedUserWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              AppStrings.continueAsGuest,
              style: AppFontStyle.medium16(
                context: context,
              ).copyWith(color: AppColors.primerColor),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            CustomButton(
              text: AppStrings.loginButton,
              radius: 100,
              onPressed: () => context.go(Routes.login),
            ),
          ],
        ),
      ),
    );
  }
}
