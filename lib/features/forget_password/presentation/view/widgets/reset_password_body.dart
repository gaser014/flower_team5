import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/routes/routes.dart';
import '../../../../../core/values/app_font_style.dart';
import '../../../../../core/values/app_strings.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/text_field/password_field.dart';
import '../../view_model/cubit/forget_password_cubit.dart';
import '../../view_model/cubit/forget_password_states.dart';

class ResetPasswordBody extends StatelessWidget {
  const ResetPasswordBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ForgetPasswordCubit>();

    return BlocListener<ForgetPasswordCubit, ForgetPasswordState>(
      listener: (context, state) {
        if (state is ResetPasswordSuccess) {
          // Navigate to login or success screen
          context.go(Routes.login);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        } else if (state is ForgetPasswordError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Form(
        key: cubit.resetPasswordFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              AppStrings.resetPasswordTitle,
              textAlign: TextAlign.center,
              style: AppFontStyle.semiBold24(context: context),
            ),
            Gap(8.h),
            Text(
              AppStrings.resetPasswordSubtitle,
              textAlign: TextAlign.center,
              style: AppFontStyle.regular16(context: context),
            ),
            Gap(32.h),
            PasswordField(
              controller: cubit.newPasswordController,
              labelText: AppStrings.newPassword,
            ),
            Gap(16.h),
            PasswordField(
              controller: cubit.confirmPasswordController,
              labelText: AppStrings.confirmNewPassword,
              validator: (value) {
                if (value != cubit.newPasswordController.text) {
                  return AppStrings.confirmPasswordMismatch;
                }
                return null;
              },
            ),
            Gap(32.h),
            BlocBuilder<ForgetPasswordCubit, ForgetPasswordState>(
              builder: (context, state) {
                return CustomButton(
                  text: AppStrings.confirm,
                  isLoading: state is ForgetPasswordLoading,
                  onPressed: () => cubit.resetPassword(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
