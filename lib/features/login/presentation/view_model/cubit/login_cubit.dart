import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flowers_app/config/base_state/base_state.dart';
import 'package:flowers_app/features/login/presentation/view_model/cubit/login_events.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'login_states.dart';

@injectable
class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(const LoginStates());

  void doIndented(LoginEvents event) {
    switch (event) {
      case LoginEvent():
        _login(event.email, event.password);
      case RememberMeEvent():
        _rememberMe(event.rememberMe);
      case ShowPasswordEvent():
        _showPassword(event.showPassword);
    }
  }

  Future<void> _login(String email, String password) async {}

  Future<void> _rememberMe(bool rememberMe) async {
    emit(state.copyWith(rememberMeState: BaseState.success(rememberMe)));
  }

  Future<void> _showPassword(bool showPassword) async {
    emit(state.copyWith(showPasswordState: BaseState.success(showPassword)));
  }
}
