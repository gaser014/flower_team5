import 'package:flowers_app/core/values/app_strings.dart';
import 'package:flowers_app/core/widgets/custom_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../view_model/cubit/forget_password_cubit.dart';
import '../widgets/verify_code_body.dart';

class VerifyCodePage extends StatelessWidget {
  final ForgetPasswordCubit cubit;
  const VerifyCodePage({super.key, required this.cubit});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: cubit,
      child: Scaffold(
        appBar: const CustomAppBar(title: AppStrings.password),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
          child: const VerifyCodeBody(),
        ),
      ),
    );
  }
}
