import 'package:flowers_app/config/uses_cases/login_params.dart';

sealed class LoginDriverEvents {}

class LoginDriverEvent extends LoginDriverEvents {
  final LoginParams params;
  LoginDriverEvent({required this.params});
}

class RememberMeDriverEvent extends LoginDriverEvents {
  final bool rememberMe;
  RememberMeDriverEvent({required this.rememberMe});
}

class ShowPasswordDriverEvent extends LoginDriverEvents {
  final bool showPassword;
  ShowPasswordDriverEvent({required this.showPassword});
}

class LogoutDriverEvent extends LoginDriverEvents {}
