import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:flowers_app/core/values/app_strings.dart';
import 'package:flowers_app/core/widgets/custom_app_bar.dart';
import '../../view_model/bloc/forget_password_bloc.dart';
import '../widgets/reset_password_body.dart';

class ResetPasswordPage extends StatelessWidget {
  final ForgetPasswordBloc bloc;
  const ResetPasswordPage({super.key, required this.bloc});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: Scaffold(
        appBar: const CustomAppBar(title: AppStrings.resetPasswordTitle),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
          child: const ResetPasswordBody(),
        ),
      ),
    );
  }
}
