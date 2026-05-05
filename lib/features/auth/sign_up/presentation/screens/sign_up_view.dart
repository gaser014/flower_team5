import 'package:flowers_app/config/dependency_injection/di.dart';
import 'package:flowers_app/core/routes/routes.dart';
import 'package:flowers_app/core/validations/validations.dart';
import 'package:flowers_app/core/values/app_strings.dart';
import 'package:flowers_app/core/widgets/custom_app_bar.dart';
import 'package:flowers_app/core/widgets/custom_button.dart';
import 'package:flowers_app/core/widgets/custom_toast.dart';
import 'package:flowers_app/core/widgets/login_link.dart';
import 'package:flowers_app/core/widgets/text_field/email_field.dart';
import 'package:flowers_app/core/widgets/text_field/password_field.dart';
import 'package:flowers_app/core/widgets/text_field/phone_field.dart';
import 'package:flowers_app/features/auth/sign_up/presentation/cubit/sign_up_cubit.dart';
import 'package:flowers_app/features/auth/sign_up/presentation/cubit/sign_up_state.dart';
import 'package:flowers_app/features/auth/sign_up/presentation/widgets/gender_selector.dart';
import 'package:flowers_app/features/auth/sign_up/presentation/widgets/name_field.dart';
import 'package:flowers_app/features/auth/sign_up/presentation/widgets/terms_and_conditions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<SignUpCubit>(),
      child: const _SignUpViewBody(),
    );
  }
}

class _SignUpViewBody extends StatelessWidget {
  const _SignUpViewBody();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: AppStrings.registerTitle),
      body: BlocConsumer<SignUpCubit, SignUpState>(
        listenWhen: (previous, current) => previous.status != current.status,
        listener: (context, state) {
          if (state.status == SignUpStatus.success) {
            CustomToast.showSuccess(
              context: context,
              title: AppStrings.success,
              message:
                  state.data?.message ?? AppStrings.accountCreatedSuccessfully,
            );
            context.pushReplacement(Routes.login);
          } else if (state.status == SignUpStatus.error) {
            CustomToast.showError(
              context: context,
              title: AppStrings.error,
              message: state.errorMessage ?? AppStrings.somethingWentWrong,
            );
          }
        },
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          final cubit = context.read<SignUpCubit>();
          return SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Form(
              key: cubit.formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: NameField(
                          controller: cubit.firstNameController,
                          labelText: AppStrings.firstName,
                          hintText: AppStrings.firstNameHint,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppStrings.firstNameRequired;
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: NameField(
                          controller: cubit.lastNameController,
                          labelText: AppStrings.lastName,
                          hintText: AppStrings.lastNameHint,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppStrings.lastNameRequired;
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  EmailField(controller: cubit.emailController),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: PasswordField(
                          controller: cubit.passwordController,
                          labelText: AppStrings.password,
                          validator: Validations.validatePassword,
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: PasswordField(
                          controller: cubit.confirmPasswordController,
                          labelText: AppStrings.confirmPassword,
                          validator: (value) =>
                              Validations.validatePasswordVerification(
                                value,
                                cubit.passwordController.text,
                              ),
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  PhoneField(controller: cubit.phoneController),
                  const SizedBox(height: 24),

                  const GenderSelector(),
                  const SizedBox(height: 16),

                  // Terms & Conditions
                  const TermsAndConditions(),
                  const SizedBox(height: 24),

                  // Sign Up button
                  CustomButton(
                    text: AppStrings.signUp,
                    isLoading: state.status == SignUpStatus.loading,
                    onPressed: cubit.signUp,
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: AuthNavigationLink(
                      title: AppStrings.alreadyHaveAnAccount,
                      actionTitle: AppStrings.loginTitle,
                      action: () => context.go(Routes.login),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
