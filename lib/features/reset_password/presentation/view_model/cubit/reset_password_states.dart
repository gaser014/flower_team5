part of 'reset_password_cubit.dart';

class ResetPasswordStates extends Equatable {
  final BaseState resetPasswordState;

  const ResetPasswordStates({
    this.resetPasswordState = const BaseState.initial(),
  });

  ResetPasswordStates copyWith({
    BaseState? resetPasswordState,
  }) {
    return ResetPasswordStates(
      resetPasswordState: resetPasswordState ?? this.resetPasswordState,
    );
  }

  @override
  List<Object?> get props => [resetPasswordState];
}
