import 'package:flowers_app/config/uses_cases/login_params.dart';
import 'package:flowers_app/core/routes/routes.dart';
import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/core/values/app_strings.dart';
import 'package:flowers_app/core/widgets/custom_button.dart';
import 'package:flowers_app/core/widgets/custom_toast.dart';
import 'package:flowers_app/core/widgets/text_field/email_field.dart';
import 'package:flowers_app/core/widgets/text_field/password_field.dart';
import 'package:flowers_app/features/login/presentation/view/widgets/dont_have_account_section.dart';
import 'package:flowers_app/features/login/presentation/view_model/cubit/login_cubit.dart';
import 'package:flowers_app/features/login/presentation/view_model/cubit/login_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginPageBody extends StatelessWidget {
  const LoginPageBody({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        spacing: 16,
        children: [
          Form(
            key: formKey,
            child: Column(
              spacing: 16,
              children: [
                EmailField(controller: emailController),
                BlocBuilder<LoginCubit, LoginStates>(
                  buildWhen: (previous, current) =>
                      previous.showPasswordState != current.showPasswordState,
                  builder: (context, state) {
                    return PasswordField(
                      controller: passwordController,
                      obscureText: state.showPasswordState.data ?? false,
                      suffixIcon: IconButton(
                        icon: Icon(
                          (state.showPasswordState.data ?? false)
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          context.read<LoginCubit>().doIndented(
                            ShowPasswordEvent(
                              showPassword:
                                  !(state.showPasswordState.data ?? false),
                            ),
                          );
                        },
                      ),
                    );
                  },
                ),
                Row(
                  children: [
                    BlocBuilder<LoginCubit, LoginStates>(
                      buildWhen: (previous, current) =>
                          previous.rememberMeState != current.rememberMeState,
                      builder: (context, state) {
                        return Checkbox(
                          value: state.rememberMeState.data ?? false,
                          onChanged: (value) {
                            context.read<LoginCubit>().doIndented(
                              RememberMeEvent(rememberMe: value ?? false),
                            );
                          },
                        );
                      },
                    ),
                    Text(AppStrings.rememberMe),
                    Spacer(),
                    TextButton(
                      onPressed: () => context.push(Routes.forgetPassword),
                      child: Text(AppStrings.forgotPassword),
                    ),
                  ],
                ),

                const SizedBox(height: 32),
                BlocConsumer<LoginCubit, LoginStates>(
                  listenWhen: (previous, current) =>
                      previous.loginState != current.loginState,
                  listener: (context, state) {
                    if (state.loginState.isSuccess) {
                      CustomToast(
                        context: context,
                        message: AppStrings.loginSuccessfully,
                      ).show();
                    } else if (state.loginState.isError) {
                      CustomToast(
                        context: context,
                        message: state.loginState.exception?.toString() ?? '',
                      ).show();
                    }
                  },
                  buildWhen: (previous, current) =>
                      previous.loginState != current.loginState,
                  builder: (context, state) {
                    return CustomButton(
                      text: AppStrings.loginTitle,
                      isLoading: state.loginState.isLoading,
                      onPressed: () {
                        context.read<LoginCubit>().doIndented(
                          LoginEvent(
                            params: LoginParams(
                              email: emailController.text,
                              password: passwordController.text,
                              remember: state.rememberMeState.data ?? false,
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
                CustomButton(
                  backgroundColor: AppColors.transparent,
                  textColor: AppColors.gray53,
                  text: AppStrings.continueAsGuest,
                  borderSide: BorderSide(color: AppColors.gray53, width: 1),
                  onPressed: () {},
                ),
              ],
            ),
          ),

          const DontHaveAccountSection(),
        ],
      ),
    );
  }
}
