import 'package:flowers_app/features/auth/sign_up/domain/entities/user_entity.dart';

class SignUpEntity {
  String? message;

  String? token;

  UserEntity? user;

  SignUpEntity({this.message, this.token, this.user});

  SignUpEntity copyWith({String? message, String? token, UserEntity? user}) {
    return SignUpEntity(
      message: message ?? this.message,
      token: token ?? this.token,
      user: user ?? this.user,
    );
  }
}
