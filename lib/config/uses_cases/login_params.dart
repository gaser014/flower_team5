import 'package:flowers_app/config/uses_cases/params.dart';

class LoginParams extends Params {
  final String email;
  final String password;
  final bool? remember;
  final String? lang;

  const LoginParams({
    required this.email,
    required this.password,
    this.remember,
    required this.lang,
  });

  @override
  List<Object?> get props => [email, password, remember, lang];
}
