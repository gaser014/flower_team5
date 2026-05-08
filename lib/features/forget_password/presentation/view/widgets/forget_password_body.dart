import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../../../core/routes/routes.dart';
import 'package:flowers_app/core/values/app_font_style.dart';
import 'package:flowers_app/core/values/app_strings.dart';
import 'package:flowers_app/core/widgets/custom_button.dart';
import 'package:flowers_app/core/widgets/text_field/email_field.dart';
import '../../view_model/cubit/forget_password_cubit.dart';
import '../../view_model/cubit/forget_password_states.dart';

class ForgetPasswordBody extends StatelessWidget {
  const ForgetPasswordBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ForgetPasswordCubit>();

    return BlocListener<ForgetPasswordCubit, ForgetPasswordState>(
      listener: (context, state) {
        if (state is SendCodeSuccess) {
          context.push(Routes.verifyCode, extra: cubit);
        } else if (state is ForgetPasswordError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        }
      },
      child: Form(
        key: cubit.forgetPasswordFormKey,
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
            EmailField(controller: cubit.emailController),
            Gap(32.h),
            BlocBuilder<ForgetPasswordCubit, ForgetPasswordState>(
              builder: (context, state) {
                return CustomButton(
                  text: AppStrings.confirmForgetPassword,
                  isLoading: state is ForgetPasswordLoading,
                  onPressed: () => cubit.sendCode(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
