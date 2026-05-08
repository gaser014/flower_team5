import 'package:equatable/equatable.dart';

abstract class ForgetPasswordEvent extends Equatable {
  const ForgetPasswordEvent();

  @override
  List<Object?> get props => [];
}
// event to send code
class SendCodeEvent extends ForgetPasswordEvent {}
// event to verify code
class VerifyCodeEvent extends ForgetPasswordEvent {}
// event to reset password
class ResetPasswordEvent extends ForgetPasswordEvent {}
