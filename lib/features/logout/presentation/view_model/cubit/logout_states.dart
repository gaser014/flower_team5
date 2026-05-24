part of 'logout_cubit.dart';

class LogoutStates extends Equatable {
  final BaseState<void> logoutState;

  const LogoutStates({
    this.logoutState = const BaseState.initial(),
  });

  LogoutStates copyWith({
    BaseState<void>? logoutState,
  }) {
    return LogoutStates(
      logoutState: logoutState ?? this.logoutState,
    );
  }

  @override
  List<Object?> get props => [logoutState];
}
