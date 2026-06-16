part of 'login_Driver_cubit.dart';

class LoginDriverStates extends Equatable {
  final BaseState loginState;
  final BaseState<bool> rememberMeState;
  final BaseState<bool> showPasswordState;
  final BaseState logoutState;
  final BaseState<Map<String, String?>> savedCredentials;

  const LoginDriverStates({
    this.loginState = const BaseState.initial(),
    this.rememberMeState = const BaseState.success(false),
    this.showPasswordState = const BaseState.success(false),
    this.logoutState = const BaseState.initial(),
    this.savedCredentials = const BaseState.initial(),
  });

  LoginDriverStates copyWith({
    BaseState? loginState,
    BaseState<bool>? rememberMeState,
    BaseState<bool>? showPasswordState,
    BaseState? logoutState,
    BaseState<Map<String, String?>>? savedCredentials,
  }) {
    return LoginDriverStates(
      loginState: loginState ?? this.loginState,
      rememberMeState: rememberMeState ?? this.rememberMeState,
      showPasswordState: showPasswordState ?? this.showPasswordState,
      logoutState: logoutState ?? this.logoutState,
      savedCredentials: savedCredentials ?? this.savedCredentials,
    );
  }

  @override
  List<Object?> get props => [
    loginState,
    rememberMeState,
    showPasswordState,
    logoutState,
    savedCredentials,
  ];
}
