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
import 'package:flowers_app/features/auth/sign_up/domain/entities/user_entity.dart';
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

class _SignUpViewBody extends StatefulWidget {
  const _SignUpViewBody();

  @override
  State<_SignUpViewBody> createState() => _SignUpViewBodyState();
}

class _SignUpViewBodyState extends State<_SignUpViewBody> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _signUp(BuildContext context, SignUpCubit cubit) {
    if (!_formKey.currentState!.validate()) {
      debugPrint("Validation failed");
      return;
    }

    String phoneNumber = _phoneController.text.trim();
    if (phoneNumber.startsWith('0')) {
      phoneNumber = phoneNumber.substring(1);
    }
    phoneNumber = "+20$phoneNumber";

    final params = UserEntity(
      firstName: _firstNameController.text.trim(),
      lastName: _lastNameController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text,
      rePassword: _confirmPasswordController.text,
      phone: phoneNumber,
      gender: cubit.state.gender.value,
    );

    cubit.doIntent(SignUpUserEvent(params: params));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: AppStrings.registerTitle),
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
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Center(
                  //   child: SvgPicture.asset(AppIcons.flower.path, height: 80),
                  // ),
                  // const SizedBox(height: 24),
                  Row(
                    children: [
                      Expanded(
                        child: NameField(
                          controller: _firstNameController,
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
                          controller: _lastNameController,
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

                  EmailField(controller: _emailController),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: PasswordField(
                          controller: _passwordController,
                          labelText: AppStrings.password,
                          validator: Validations.validatePassword,
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: PasswordField(
                          controller: _confirmPasswordController,
                          labelText: AppStrings.confirmPassword,
                          validator: (value) =>
                              Validations.validatePasswordVerification(
                                value,
                                _passwordController.text,
                              ),
                          textInputAction: TextInputAction.next,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  PhoneField(controller: _phoneController),
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
                    onPressed: () => _signUp(context, cubit),
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
