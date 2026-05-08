import 'package:equatable/equatable.dart';

abstract class ForgetPasswordState extends Equatable {
  const ForgetPasswordState();

  @override
  List<Object?> get props => [];
}

class ForgetPasswordInitial extends ForgetPasswordState {}

class ForgetPasswordLoading extends ForgetPasswordState {}

class SendCodeSuccess extends ForgetPasswordState {
  final String message;
  const SendCodeSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class VerifyCodeSuccess extends ForgetPasswordState {
  final String message;
  const VerifyCodeSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class ResetPasswordSuccess extends ForgetPasswordState {
  final String message;
  const ResetPasswordSuccess(this.message);

  @override
  List<Object?> get props => [message];
}

class ForgetPasswordError extends ForgetPasswordState {
  final String message;
  const ForgetPasswordError(this.message);

  @override
  List<Object?> get props => [message];
}

class ForgetPasswordSuccess extends ForgetPasswordState {
  final String message;
  const ForgetPasswordSuccess(this.message);

  @override
  List<Object?> get props => [message];
}
