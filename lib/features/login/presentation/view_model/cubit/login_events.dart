sealed class LoginEvents {}

class LoginEvent extends LoginEvents {
  final String email;
  final String password;
  LoginEvent({required this.email, required this.password});
}

class RememberMeEvent extends LoginEvents {
  final bool rememberMe;
  RememberMeEvent({required this.rememberMe});
}

class ShowPasswordEvent extends LoginEvents {
  final bool showPassword;
  ShowPasswordEvent({required this.showPassword});
}
