import 'package:flowers_app/features/login_Driver/presentation/view/widgets/login_driver_form_section.dart';
import 'package:flutter/material.dart';

class LoginDriverBody extends StatelessWidget {
  const LoginDriverBody({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.isPasswordVisible,
    required this.rememberMe,
    required this.isLoading,
    required this.onTogglePasswordVisibility,
    required this.onRememberMeChanged,
    required this.onForgotPasswordTapped,
    required this.onSubmit,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  final bool isPasswordVisible;
  final bool rememberMe;
  final bool isLoading;

  final VoidCallback onTogglePasswordVisibility;
  final ValueChanged<bool> onRememberMeChanged;
  final VoidCallback onForgotPasswordTapped;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        spacing: 16,
        children: [
          LoginDriverFormSection(
            formKey: formKey,
            emailController: emailController,
            passwordController: passwordController,
            isPasswordVisible: isPasswordVisible,
            rememberMe: rememberMe,
            isLoading: isLoading,
            onTogglePasswordVisibility: onTogglePasswordVisibility,
            onRememberMeChanged: onRememberMeChanged,
            onForgotPasswordTapped: onForgotPasswordTapped,
            onSubmit: onSubmit,
          ),
        ],
      ),
    );
  }
}
