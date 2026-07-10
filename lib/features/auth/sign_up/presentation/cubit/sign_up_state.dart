import 'package:equatable/equatable.dart';
import 'package:flowers_app/config/helper/enum/gender.dart';
import 'package:flowers_app/features/auth/sign_up/domain/entities/sign_up_entity.dart';

enum SignUpStatus { initial, loading, success, error }

class SignUpState extends Equatable {
  final SignUpStatus status;
  final SignUpEntity? data;
  final String? errorMessage;
  final bool isPasswordVisible;
  final bool isConfirmPasswordVisible;
  final Gender gender;

  const SignUpState({
    this.status = SignUpStatus.initial,
    this.data,
    this.errorMessage,
    this.isPasswordVisible = false,
    this.isConfirmPasswordVisible = false,
    this.gender = Gender.female,
  });

  SignUpState copyWith({
    SignUpStatus? status,
    SignUpEntity? data,
    String? errorMessage,
    bool? isPasswordVisible,
    bool? isConfirmPasswordVisible,
    Gender? gender,
  }) {
    return SignUpState(
      status: status ?? this.status,
      data: data ?? this.data,
      errorMessage: errorMessage ?? this.errorMessage,
      isPasswordVisible: isPasswordVisible ?? this.isPasswordVisible,
      isConfirmPasswordVisible:
          isConfirmPasswordVisible ?? this.isConfirmPasswordVisible,
      gender: gender ?? this.gender,
    );
  }

  @override
  List<Object?> get props => [
    status,
    data,
    errorMessage,
    isPasswordVisible,
    isConfirmPasswordVisible,
    gender,
  ];
}
