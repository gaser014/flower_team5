import 'package:flowers_app/config/dependency_injection/di.dart';
import 'package:flowers_app/core/routes/routes.dart';
import 'package:flowers_app/core/values/app_font_style.dart';
import 'package:flowers_app/core/values/app_strings.dart';
import 'package:flowers_app/core/widgets/custom_app_bar.dart';
import 'package:flowers_app/core/widgets/custom_button.dart';
import 'package:flowers_app/core/widgets/resend_timer_widget.dart';
import 'package:flowers_app/core/widgets/text_field/email_field.dart';
import 'package:flowers_app/core/widgets/text_field/otp_input_field.dart';
import 'package:flowers_app/core/widgets/text_field/password_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../view_model/bloc/forget_password_bloc.dart';
import '../../view_model/bloc/forget_password_events.dart';
import '../../view_model/bloc/forget_password_states.dart';

class ForgetPasswordPage extends StatelessWidget {
  const ForgetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ForgetPasswordBloc>(),
      child: BlocBuilder<ForgetPasswordBloc, ForgetPasswordState>(
        builder: (context, state) {
          final bloc = context.read<ForgetPasswordBloc>();

          String title = AppStrings.password;
          if (bloc.pageController.hasClients) {
            if (bloc.pageController.page == 2) {
              title = AppStrings.resetPasswordTitle;
            }
          }

          return Scaffold(
            appBar: CustomAppBar(
              title: title,
              onBackPressed: () {
                if (bloc.pageController.hasClients &&
                    (bloc.pageController.page ?? 0) > 0) {
                  bloc.pageController.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                } else {
                  context.pop();
                }
              },
            ),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
              child: PageView(
                controller: bloc.pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: const [
                  _ForgetPasswordBody(),
                  _VerifyCodeBody(),
                  _ResetPasswordBody(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _ForgetPasswordBody extends StatelessWidget {
  const _ForgetPasswordBody();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ForgetPasswordBloc>();

    return BlocListener<ForgetPasswordBloc, ForgetPasswordState>(
      listener: (context, state) {
        if (state is SendCodeSuccess) {
          bloc.pageController.animateToPage(
            1,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        } else if (state is ForgetPasswordError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Form(
        key: bloc.forgetPasswordFormKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              AppStrings.forgetPasswordTitle,
              textAlign: TextAlign.center,
              style: AppFontStyle.semiBold24(context: context),
            ),
            Gap(8.h),
            Text(
              AppStrings.forgetPasswordSubtitle,
              textAlign: TextAlign.center,
              style: AppFontStyle.regular16(context: context),
            ),
            Gap(32.h),
            EmailField(controller: bloc.emailController),
            Gap(32.h),
            BlocBuilder<ForgetPasswordBloc, ForgetPasswordState>(
              builder: (context, state) {
                return CustomButton(
                  text: AppStrings.confirmForgetPassword,
                  isLoading: state is ForgetPasswordLoading,
                  onPressed: () => bloc.add(SendCodeEvent()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _VerifyCodeBody extends StatelessWidget {
  const _VerifyCodeBody();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ForgetPasswordBloc>();

    return BlocListener<ForgetPasswordBloc, ForgetPasswordState>(
      listener: (context, state) {
        if (state is VerifyCodeSuccess) {
          bloc.pageController.animateToPage(
            2,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        } else if (state is ResendCodeSuccess) {
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
        key: bloc.verifyCodeFormKey,
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
            BlocBuilder<ForgetPasswordBloc, ForgetPasswordState>(
              builder: (context, state) {
                return Column(
                  children: [
                    OtpInputField(
                      controller: bloc.otpController,
                      length: 4,
                      hasError: state is ForgetPasswordError,
                      onCompleted: (pin) => bloc.add(VerifyCodeEvent()),
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
            ResendTimerWidget(onResend: () => bloc.add(ResendCodeEvent())),
            Gap(32.h),
            BlocBuilder<ForgetPasswordBloc, ForgetPasswordState>(
              builder: (context, state) {
                return CustomButton(
                  text: AppStrings.confirm,
                  isLoading: state is ForgetPasswordLoading,
                  onPressed: () => bloc.add(VerifyCodeEvent()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _ResetPasswordBody extends StatelessWidget {
  const _ResetPasswordBody();

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ForgetPasswordBloc>();

    return BlocListener<ForgetPasswordBloc, ForgetPasswordState>(
      listener: (context, state) {
        if (state is ResetPasswordSuccess) {
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
        key: bloc.resetPasswordFormKey,
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
              controller: bloc.newPasswordController,
              labelText: AppStrings.newPassword,
            ),
            Gap(16.h),
            PasswordField(
              controller: bloc.confirmPasswordController,
              labelText: AppStrings.confirmNewPassword,
              validator: (value) {
                if (value != bloc.newPasswordController.text) {
                  return AppStrings.confirmPasswordMismatch;
                }
                return null;
              },
            ),
            Gap(32.h),
            BlocBuilder<ForgetPasswordBloc, ForgetPasswordState>(
              builder: (context, state) {
                return CustomButton(
                  text: AppStrings.confirm,
                  isLoading: state is ForgetPasswordLoading,
                  onPressed: () => bloc.add(ResetPasswordEvent()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
