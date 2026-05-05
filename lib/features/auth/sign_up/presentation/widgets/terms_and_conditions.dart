import 'package:flowers_app/core/routes/routes.dart';
import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/core/values/app_font_style.dart';
import 'package:flowers_app/core/values/app_strings.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({super.key});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        text: AppStrings.termsConditionsPart1,
        style: AppFontStyle.regular12(context: context).copyWith(
          color: AppColors.black0C.withValues(alpha: 0.7),
        ),
        children: [
          TextSpan(
            text: AppStrings.termsConditionsPart2,
            style: AppFontStyle.semiBold12(context: context).copyWith(
              color: AppColors.black0C,
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                context.push(Routes.termsAndConditions);
              },
          ),
        ],
      ),
    );
  }
}
