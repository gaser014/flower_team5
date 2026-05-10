part of 'login_cubit.dart';

class LoginStates extends Equatable {
  final BaseState loginState;
  final BaseState<bool> rememberMeState;
  final BaseState<bool> showPasswordState;

  const LoginStates({
    this.loginState = const BaseState.initial(),
    this.rememberMeState = const BaseState.initial(),
    this.showPasswordState = const BaseState.initial(),
  });

  LoginStates copyWith({
    BaseState? loginState,
    BaseState<bool>? rememberMeState,
    BaseState<bool>? showPasswordState,
  }) {
    return LoginStates(
      loginState: loginState ?? this.loginState,
      rememberMeState: rememberMeState ?? this.rememberMeState,
      showPasswordState: showPasswordState ?? this.showPasswordState,
    );
  }

  @override
  List<Object?> get props => [loginState, rememberMeState, showPasswordState];
}
