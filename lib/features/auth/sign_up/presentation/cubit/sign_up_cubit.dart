import 'package:flowers_app/config/helper/enum/gender.dart';
import 'package:flowers_app/core/values/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flowers_app/features/auth/sign_up/domain/use_cases/sign_up_use_case.dart';
import 'package:injectable/injectable.dart';

import 'sign_up_state.dart';

@injectable
class SignUpCubit extends Cubit<SignUpState> {
  final SignUpUseCase _signUpUseCase;

  SignUpCubit(this._signUpUseCase) : super(const SignUpState());





  void togglePasswordVisibility() {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  void toggleConfirmPasswordVisibility() {
    emit(state.copyWith(
        isConfirmPasswordVisible: !state.isConfirmPasswordVisible));
  }

  void changeGender(Gender gender) {
    emit(state.copyWith(gender: gender));
  }

  Future<void> signUp(SignUpParams params) async {
    emit(state.copyWith(status: SignUpStatus.loading));
    debugPrint("Signing up with: ${params.firstName}, ${params.email}");

    final result = await _signUpUseCase.call(params);

    result.when(
      success: (data) async {
        debugPrint("Sign up success: ${data?.message}");
        emit(state.copyWith(
          status: SignUpStatus.success,
          data: data,
        ));
      },
      error: (exception) {
        debugPrint("Sign up error: $exception");
        emit(state.copyWith(
          status: SignUpStatus.error,
          errorMessage: exception?.toString() ??
              AppStrings.anUnexpectedErrorOccurred,
        ));
      },
    );
  }

}
