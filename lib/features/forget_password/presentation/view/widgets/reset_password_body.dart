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
import '../../view_model/bloc/forget_password_bloc.dart';
import '../../view_model/bloc/forget_password_events.dart';
import '../../view_model/bloc/forget_password_states.dart';

class ResetPasswordBody extends StatefulWidget {
  const ResetPasswordBody({super.key});

  @override
  State<ResetPasswordBody> createState() => _ResetPasswordBodyState();
}

class _ResetPasswordBodyState extends State<ResetPasswordBody> {
  late final GlobalKey<FormState> _formKey;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ForgetPasswordBloc>();

    return BlocListener<ForgetPasswordBloc, ForgetPasswordState>(
      listener: (context, state) {
        if (state is ResetPasswordSuccess) {
          context.go(Routes.login);
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        } else if (state is ForgetPasswordError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Form(
        key: _formKey,
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
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      bloc.add(ResetPasswordEvent());
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
