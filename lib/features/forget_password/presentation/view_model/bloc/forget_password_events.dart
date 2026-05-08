import 'package:equatable/equatable.dart';

abstract class ForgetPasswordEvent extends Equatable {
  const ForgetPasswordEvent();

  @override
  List<Object?> get props => [];
}

// event to send code
class SendCodeEvent extends ForgetPasswordEvent {
  final bool isReSend;
  const SendCodeEvent({this.isReSend=false});
}

// event to verify code
class VerifyCodeEvent extends ForgetPasswordEvent {}

// event to reset password
class ResetPasswordEvent extends ForgetPasswordEvent {}
