import 'package:flowers_app/config/helper/enum/gender.dart';
import 'package:flowers_app/core/values/app_strings.dart';
import 'package:flowers_app/features/auth/sign_up/domain/entities/user_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flowers_app/features/auth/sign_up/domain/use_cases/sign_up_use_case.dart';
import 'package:injectable/injectable.dart';

import 'sign_up_state.dart';

part 'sign_up_events.dart';

@injectable
class SignUpCubit extends Cubit<SignUpState> {
  final SignUpUseCase _signUpUseCase;

  SignUpCubit(this._signUpUseCase) : super(const SignUpState());

  // Private Controllers
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Getters for controllers and form key
  TextEditingController get firstNameController => _firstNameController;
  TextEditingController get lastNameController => _lastNameController;
  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;
  TextEditingController get confirmPasswordController =>
      _confirmPasswordController;
  TextEditingController get phoneController => _phoneController;
  GlobalKey<FormState> get formKey => _formKey;

  void doIntent(SignUpEvents event) {
    if (event is SignUpUserEvent) {
      _signUp(event.params);
    }
  }

  void togglePasswordVisibility() {
    emit(state.copyWith(isPasswordVisible: !state.isPasswordVisible));
  }

  void toggleConfirmPasswordVisibility() {
    emit(
      state.copyWith(isConfirmPasswordVisible: !state.isConfirmPasswordVisible),
    );
  }

  void changeGender(Gender gender) {
    emit(state.copyWith(gender: gender));
  }

  Future<void> _signUp(UserEntity params) async {
    emit(state.copyWith(status: SignUpStatus.loading));
    debugPrint("Signing up with: ${params.firstName}, ${params.email}");

    final result = await _signUpUseCase.call(params);

    result.when(
      success: (data) async {
        debugPrint("Sign up success: ${data?.message}");
        emit(state.copyWith(status: SignUpStatus.success, data: data));
      },
      error: (exception) {
        debugPrint("Sign up error: $exception");
        emit(
          state.copyWith(
            status: SignUpStatus.error,
            errorMessage:
                exception?.toString() ?? AppStrings.anUnexpectedErrorOccurred,
          ),
        );
      },
    );
  }

  // Helper method for the view
  void signUp() {
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
      gender: state.gender.value,
    );

    doIntent(SignUpUserEvent(params: params));
  }

  @override
  Future<void> close() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneController.dispose();
    return super.close();
  }
}
