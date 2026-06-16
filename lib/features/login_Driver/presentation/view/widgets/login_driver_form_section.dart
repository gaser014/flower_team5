import 'package:flowers_app/core/widgets/text_field/email_field.dart';
import 'package:flowers_app/features/login_Driver/presentation/view/widgets/login_driver_password_field.dart';
import 'package:flowers_app/features/login_Driver/presentation/view/widgets/login_driver_submit_button.dart';
import 'package:flowers_app/features/login_Driver/presentation/view/widgets/remember_me_driver_row.dart';
import 'package:flutter/material.dart';

class LoginDriverFormSection extends StatelessWidget {
  const LoginDriverFormSection({
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

  // state values
  final bool isPasswordVisible;
  final bool rememberMe;
  final bool isLoading;

  // callbacks
  final VoidCallback onTogglePasswordVisibility;
  final ValueChanged<bool> onRememberMeChanged;
  final VoidCallback onForgotPasswordTapped;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        spacing: 16,
        children: [
          EmailField(controller: emailController),
          LoginDriverPasswordField(
            passwordController: passwordController,
            isVisible: isPasswordVisible,
            onToggleVisibility: onTogglePasswordVisibility,
          ),
          RememberMeDriverRow(
            rememberMe: rememberMe,
            onRememberMeChanged: onRememberMeChanged,
            onForgotPasswordTapped: onForgotPasswordTapped,
          ),
          const SizedBox(height: 32),
          LoginDriverSubmitButton(isLoading: isLoading, onPressed: onSubmit),
        ],
      ),
    );
  }
}
