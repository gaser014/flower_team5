import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flowers_app/config/dependency_injection/di.dart';
import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/core/values/app_strings.dart';
import 'package:flowers_app/core/widgets/text_field/password_field.dart';
import 'package:flowers_app/features/reset_password/data/models/reset_password_request.dart';
import 'package:flowers_app/features/reset_password/presentation/view_model/cubit/reset_password_cubit.dart';
import 'package:flowers_app/features/reset_password/presentation/view_model/cubit/reset_password_events.dart';

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool get _isFormValid => 
      _currentPasswordController.text.isNotEmpty &&
      _newPasswordController.text.isNotEmpty &&
      _confirmPasswordController.text.isNotEmpty;

  void _updateFormState() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _currentPasswordController.addListener(_updateFormState);
    _newPasswordController.addListener(_updateFormState);
    _confirmPasswordController.addListener(_updateFormState);
  }

  @override
  void dispose() {
    _currentPasswordController.removeListener(_updateFormState);
    _newPasswordController.removeListener(_updateFormState);
    _confirmPasswordController.removeListener(_updateFormState);
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _submit(BuildContext context) {
    if (_newPasswordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(AppStrings.passwordsDoNotMatch),
          backgroundColor: Colors.red,
        ),
      );
      _formKey.currentState?.validate();
      return;
    }

    if (_formKey.currentState?.validate() ?? false) {
      final request = ResetPasswordRequest(
        currentPassword: _currentPasswordController.text,
        newPassword: _newPasswordController.text,
      );
      context.read<ResetPasswordCubit>().doIndented(SubmitResetPasswordEvent(request));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<ResetPasswordCubit>(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          scrolledUnderElevation: 0,
          titleSpacing: 0,
          title: const Text(
            AppStrings.resetPasswordTitle,
            style: TextStyle(
              color: Colors.black,
              fontSize: 22,
              fontWeight: FontWeight.w600,
            ),
          ),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: BlocConsumer<ResetPasswordCubit, ResetPasswordStates>(
          listener: (context, state) {
            if (state.resetPasswordState.isSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text(AppStrings.passwordUpdatedSuccess)),
              );
              Navigator.pop(context);
            } else if (state.resetPasswordState.isError) {
              _formKey.currentState?.validate();
            }
          },
          builder: (context, state) {
            final isLoading = state.resetPasswordState.isLoading;
            final isError = state.resetPasswordState.isError;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    PasswordField(
                      controller: _currentPasswordController,
                      labelText: AppStrings.currentPassword,
                      hintText: AppStrings.currentPassword,
                      validator: (value) {
                        if (isError) return AppStrings.invalidPassword;
                        if (value == null || value.isEmpty) return AppStrings.enterCurrentPassword;
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    PasswordField(
                      controller: _newPasswordController,
                      labelText: AppStrings.newPassword,
                      hintText: AppStrings.newPassword,
                      validator: (value) {
                        if (value == null || value.isEmpty) return AppStrings.enterNewPassword;
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    PasswordField(
                      controller: _confirmPasswordController,
                      labelText: AppStrings.confirmPasswordLabel,
                      hintText: AppStrings.confirmPasswordLabel,
                      validator: (value) {
                        if (value == null || value.isEmpty) return AppStrings.pleaseConfirmNewPassword;
                        if (value != _newPasswordController.text) return AppStrings.passwordsDoNotMatch;
                        return null;
                      },
                    ),
                    const SizedBox(height: 48),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        backgroundColor: AppColors.primerColor,
                        disabledBackgroundColor: AppColors.grayCF,
                      ),
                      onPressed: (isLoading || !_isFormValid) ? null : () => _submit(context),
                      child: isLoading 
                        ? const SizedBox(
                            width: 24, 
                            height: 24, 
                            child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2),
                          ) 
                        : const Text(AppStrings.update, style: TextStyle(color: Colors.white, fontSize: 16)),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
