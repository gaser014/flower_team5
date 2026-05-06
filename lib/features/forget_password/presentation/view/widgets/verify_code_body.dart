import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/routes/routes.dart';
import '../../../../../core/values/app_font_style.dart';
import '../../../../../core/values/app_strings.dart';
import '../../../../../core/widgets/custom_button.dart';
import '../../../../../core/widgets/resend_timer_widget.dart';
import '../../../../../core/widgets/text_field/otp_input_field.dart';
import '../../view_model/cubit/forget_password_cubit.dart';
import '../../view_model/cubit/forget_password_states.dart';

class VerifyCodeBody extends StatelessWidget {
  const VerifyCodeBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ForgetPasswordCubit>();

    return BlocListener<ForgetPasswordCubit, ForgetPasswordState>(
      listener: (context, state) {
        if (state is VerifyCodeSuccess) {
          context.push(Routes.resetPassword, extra: cubit);
        } else if (state is ForgetPasswordError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Form(
        key: cubit.verifyCodeFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              AppStrings.verificationCodeTitle,
              textAlign: TextAlign.center,
              style: AppFontStyle.semiBold24(context: context),
            ),
            Gap(8.h),
            Text(
              AppStrings.verificationCodeSubtitle,
              textAlign: TextAlign.center,
              style: AppFontStyle.regular16(context: context),
            ),
            Gap(32.h),
            BlocBuilder<ForgetPasswordCubit, ForgetPasswordState>(
              builder: (context, state) {
                return Column(
                  children: [
                    OtpInputField(
                      controller: cubit.otpController,
                      length: 4,
                      hasError: state is ForgetPasswordError,
                      onCompleted: (pin) => cubit.verifyCode(),
                    ),
                    if (state is ForgetPasswordError) ...[
                      Gap(8.h),
                      const ErrorMessage(),
                    ],
                  ],
                );
              },
            ),
            Gap(16.h),
            ResendTimerWidget(onResend: () => cubit.sendCode()),
            Gap(32.h),
            BlocBuilder<ForgetPasswordCubit, ForgetPasswordState>(
              builder: (context, state) {
                return CustomButton(
                  text: AppStrings.confirm,
                  isLoading: state is ForgetPasswordLoading,
                  onPressed: () => cubit.verifyCode(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
