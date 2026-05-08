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
import '../../view_model/bloc/forget_password_bloc.dart';
import '../../view_model/bloc/forget_password_events.dart';
import '../../view_model/bloc/forget_password_states.dart';

class ForgetPasswordBody extends StatefulWidget {
  const ForgetPasswordBody({super.key});

  @override
  State<ForgetPasswordBody> createState() => _ForgetPasswordBodyState();
}

class _ForgetPasswordBodyState extends State<ForgetPasswordBody> {
  late final GlobalKey<FormState> _formKey;

  @override
  void initState() {
    _formKey = GlobalKey<FormState>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ForgetPasswordBloc>();

    return BlocListener<ForgetPasswordBloc, ForgetPasswordState>(
      listener: (context, state) {
        if (state is SendCodeSuccess) {
          if (!state.isResend) context.push(Routes.verifyCode, extra: bloc);
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
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      bloc.add(SendCodeEvent());
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
