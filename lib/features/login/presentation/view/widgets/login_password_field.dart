import 'package:flowers_app/core/values/app_assets.dart';
import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/core/widgets/text_field/password_field.dart';
import 'package:flowers_app/features/login/presentation/view_model/cubit/login_cubit.dart';
import 'package:flowers_app/features/login/presentation/view_model/cubit/login_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPasswordField extends StatelessWidget {
  const LoginPasswordField({super.key, required this.passwordController});

  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginStates>(
      buildWhen: (previous, current) =>
          previous.showPasswordState != current.showPasswordState,
      builder: (context, state) {
        return PasswordField(
          controller: passwordController,
          obscureText: state.showPasswordState.data ?? false,
          suffixIcon: IconButton(
            icon: SvgPicture.asset(
              (state.showPasswordState.data ?? false)
                  ? AppAssets.iconsOpenEye
                  : AppAssets.iconsClosedEye,
              colorFilter: const ColorFilter.mode(
                AppColors.grayA6,
                BlendMode.srcIn,
              ),
            ),
            onPressed: () {
              context.read<LoginCubit>().doIndented(
                ShowPasswordEvent(
                  showPassword: !(state.showPasswordState.data ?? false),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
