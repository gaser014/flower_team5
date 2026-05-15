import 'package:flowers_app/features/auth/sign_up/domain/entities/user_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sign_up_request_dto.g.dart';

@JsonSerializable()
class SignUpRequestDto {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String rePassword;
  final String phone;
  final String gender;

  const SignUpRequestDto({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.rePassword,
    required this.phone,
    required this.gender,
  });

  factory SignUpRequestDto.fromJson(Map<String, dynamic> json) =>
      _$SignUpRequestDtoFromJson(json);
  factory SignUpRequestDto.fromUserEntity(UserEntity user) {
    return SignUpRequestDto(
      firstName: user.firstName,
      lastName: user.lastName,
      email: user.email,
      password: user.password,
      rePassword: user.rePassword,
      gender: user.gender,
      phone: user.phone,
    );
  }
  Map<String, dynamic> toJson() => _$SignUpRequestDtoToJson(this);
}
