import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/use_cases/forget_password_use_cases.dart';
import 'forget_password_states.dart';

@injectable
class ForgetPasswordCubit extends Cubit<ForgetPasswordState> {
  // ignore: unused_field
  final SendForgetPasswordCodeUseCase _sendForgetPasswordCodeUseCase;
  // ignore: unused_field
  final VerifyForgetPasswordCodeUseCase _verifyForgetPasswordCodeUseCase;
  // ignore: unused_field
  final ResetPasswordUseCase _resetPasswordUseCase;

  // Step 1: Forget Password
  final TextEditingController emailController = TextEditingController();
  final GlobalKey<FormState> forgetPasswordFormKey = GlobalKey<FormState>();

  // Step 2: Verify Code
  final TextEditingController otpController = TextEditingController();
  final GlobalKey<FormState> verifyCodeFormKey = GlobalKey<FormState>();

  // Step 3: Reset Password
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> resetPasswordFormKey = GlobalKey<FormState>();

  ForgetPasswordCubit(
    this._sendForgetPasswordCodeUseCase,
    this._verifyForgetPasswordCodeUseCase,
    this._resetPasswordUseCase,
  ) : super(ForgetPasswordInitial());

  Future<void> sendCode() async {
    emit(ForgetPasswordLoading());

    // MOCK API CALL
    await Future.delayed(const Duration(seconds: 1));
    emit(const SendCodeSuccess("Mock: Code sent successfully"));

    /*
      final result = await _sendForgetPasswordCodeUseCase.execute(
        ForgetPasswordParams(email: emailController.text),
      );

      result.when(
        success: (data) => emit(const SendCodeSuccess("Code sent successfully")),
        error: (exception) => emit(ForgetPasswordError(exception?.toString() ?? "An error occurred")),
      );
      */
  }

  Future<void> verifyCode() async {
    emit(ForgetPasswordLoading());

    // MOCK API CALL
    await Future.delayed(const Duration(seconds: 1));
    emit(const VerifyCodeSuccess("Mock: Code verified successfully"));

    /*
      final result = await _verifyForgetPasswordCodeUseCase.execute(
        ForgetPasswordParams(
          email: emailController.text,
          resetCode: otpController.text,
        ),
      );

      result.when(
        success: (data) => emit(const VerifyCodeSuccess("Code verified successfully")),
        error: (exception) => emit(ForgetPasswordError(exception?.toString() ?? "An error occurred")),
      );
      */
  }

  Future<void> resetPassword() async {
    emit(ForgetPasswordLoading());

    // MOCK API CALL
    await Future.delayed(const Duration(seconds: 1));
    emit(const ResetPasswordSuccess("Mock: Password reset successfully"));

    /*
      final result = await _resetPasswordUseCase.execute(
        ForgetPasswordParams(
          email: emailController.text,
          newPassword: newPasswordController.text,
        ),
      );

      result.when(
        success: (data) => emit(const ResetPasswordSuccess("Password reset successfully")),
        error: (exception) => emit(ForgetPasswordError(exception?.toString() ?? "An error occurred")),
      );
      */
  }

  @override
  Future<void> close() {
    emailController.dispose();
    otpController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    return super.close();
  }
}
