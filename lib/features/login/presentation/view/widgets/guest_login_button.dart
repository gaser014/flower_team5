import 'package:flowers_app/core/routes/app_routes.dart';
import 'package:flowers_app/core/routes/routes.dart';
import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/core/values/app_strings.dart';
import 'package:flowers_app/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class GuestLoginButton extends StatelessWidget {
  const GuestLoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      // backgroundColor: AppColors.transparent,
      // textColor: AppColors.gray53,
      variant: ButtonVariant.outlined,
      text: AppStrings.continueAsGuest,
      // borderSide: const BorderSide(color: AppColors.gray53, width: 1),
      onPressed: () {
        context.go(Routes.main);
      },
    );
  }
}
