import 'package:flowers_app/features/auth/sign_up/domain/entities/user_entity.dart';

class SignUpEntity {
  final String message;
  final String token;
  final UserEntity? user;

  SignUpEntity({
    required this.message,
    required this.token,
    this.user,
  });

  SignUpEntity copyWith({
    String? message,
    String? token,
    UserEntity? user,
  }) {
    return SignUpEntity(
      message: message ?? this.message,
      token: token ?? this.token,
      user: user ?? this.user,
    );
  }
}
