import 'package:flowers_app/config/helper/enum/gender.dart';
import 'package:flowers_app/core/values/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flowers_app/core/data/data_sources/auth_local_data_source.dart';
import 'package:flowers_app/features/auth/sign_up/domain/use_cases/sign_up_use_case.dart';
import 'package:injectable/injectable.dart';

import 'sign_up_state.dart';

@injectable
class SignUpCubit extends Cubit<SignUpState> {
  final SignUpUseCase _signUpUseCase;
  final AuthLocalDataSourceContract _localDataSource;

  SignUpCubit(this._signUpUseCase, this._localDataSource) : super(const SignUpState());

  // Controllers
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final phoneController = TextEditingController();
  final formKey = GlobalKey<FormState>();

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

  Future<void> signUp() async {
    if (!formKey.currentState!.validate()) {
      debugPrint("Validation failed");
      return;
    }

    emit(state.copyWith(status: SignUpStatus.loading));
    debugPrint("Signing up with: ${firstNameController.text}, ${emailController.text}");

    String phoneNumber = phoneController.text.trim();
    if (phoneNumber.startsWith('0')) {
      phoneNumber = phoneNumber.substring(1);
    }
    phoneNumber = "+20$phoneNumber";

    final params = SignUpParams(
      firstName: firstNameController.text.trim(),
      lastName: lastNameController.text.trim(),
      email: emailController.text.trim(),
      password: passwordController.text,
      rePassword: confirmPasswordController.text,
      phone: phoneNumber,
      gender: state.gender.value,
    );

    debugPrint("Params: $params");

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

  @override
  Future<void> close() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneController.dispose();
    return super.close();
  }
}
