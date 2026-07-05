import 'package:flowers_app/features/auth/sign_up/domain/entities/sign_up_entity.dart';
import 'package:flowers_app/features/auth/sign_up/domain/entities/user_entity.dart';

class SignUpResponseModel {
  final String? message;
  final String? token;
  final Map<String, dynamic>? user;

  const SignUpResponseModel({this.message, this.token, this.user});

  factory SignUpResponseModel.fromJson(Map<String, dynamic> json) {
    return SignUpResponseModel(
      message: json['message'] as String?,
      token: json['token'] as String?,
      user: json['user'] as Map<String, dynamic>?,
    );
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
    'message': message,
    'token': token,
    'user': user,
  };

  SignUpEntity toEntity() {
    return SignUpEntity(
      message: message ?? '',
      token: token ?? '',
      user: _mapUser(),
    );
  }

  UserEntity? _mapUser() {
    final userJson = user;
    if (userJson == null) return null;

    return UserEntity(
      firstName:
          userJson['firstName'] as String? ??
          userJson['first_name'] as String? ??
          '',
      lastName:
          userJson['lastName'] as String? ??
          userJson['last_name'] as String? ??
          '',
      email: userJson['email'] as String? ?? '',
      phone: userJson['phone'] as String? ?? '',
      password: userJson['password'] as String? ?? '',
      rePassword:
          userJson['rePassword'] as String? ??
          userJson['password'] as String? ??
          '',
      gender: userJson['gender'] as String? ?? '',
    );
  }
}
