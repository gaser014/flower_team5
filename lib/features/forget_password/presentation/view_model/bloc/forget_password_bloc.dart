import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/entities/forget_password_params.dart';
import '../../../domain/use_cases/forget_password_use_cases.dart';
import 'forget_password_events.dart';
import 'forget_password_states.dart';

@injectable
class ForgetPasswordBloc
    extends Bloc<ForgetPasswordEvent, ForgetPasswordState> {
  final SendForgetPasswordCodeUseCase _sendForgetPasswordCodeUseCase;
  final VerifyForgetPasswordCodeUseCase _verifyForgetPasswordCodeUseCase;
  final ResetPasswordUseCase _resetPasswordUseCase;

  // Step 1: Forget Password
  final TextEditingController emailController = TextEditingController();

  // Step 2: Verify Code
  final TextEditingController otpController = TextEditingController();

  // Step 3: Reset Password
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  ForgetPasswordBloc(
    this._sendForgetPasswordCodeUseCase,
    this._verifyForgetPasswordCodeUseCase,
    this._resetPasswordUseCase,
  ) : super(ForgetPasswordInitial()) {
    on<SendCodeEvent>(_onSendCode);
    on<VerifyCodeEvent>(_onVerifyCode);
    on<ResetPasswordEvent>(_onResetPassword);
  }

  Future<void> _onSendCode(
    SendCodeEvent event,
    Emitter<ForgetPasswordState> emit,
  ) async {
    emit(ForgetPasswordLoading());

    // MOCK API CALL for testing
    await Future.delayed(const Duration(seconds: 1));
    emit(
      SendCodeSuccess("Mock: Code sent successfully", isResend: event.isReSend),
    );

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

  Future<void> _onVerifyCode(
    VerifyCodeEvent event,
    Emitter<ForgetPasswordState> emit,
  ) async {
    emit(ForgetPasswordLoading());

    // MOCK API CALL for testing
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

  Future<void> _onResetPassword(
    ResetPasswordEvent event,
    Emitter<ForgetPasswordState> emit,
  ) async {
    emit(ForgetPasswordLoading());

    // MOCK API CALL for testing
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
