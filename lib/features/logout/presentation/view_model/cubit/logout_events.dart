import 'package:equatable/equatable.dart';

sealed class LogoutEvents extends Equatable {
  const LogoutEvents();

  @override
  List<Object?> get props => [];
}

class DoLogoutEvent extends LogoutEvents {
  const DoLogoutEvent();
}
