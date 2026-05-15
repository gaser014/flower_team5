import 'package:json_annotation/json_annotation.dart';

part 'forget_password_request_models.g.dart';

@JsonSerializable()
class ForgetPasswordRequest {
  final String email;

  ForgetPasswordRequest({required this.email});

  factory ForgetPasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$ForgetPasswordRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ForgetPasswordRequestToJson(this);
}

@JsonSerializable()
class VerifyCodeRequest {
  final String resetCode;

  VerifyCodeRequest({required this.resetCode});

  factory VerifyCodeRequest.fromJson(Map<String, dynamic> json) =>
      _$VerifyCodeRequestFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyCodeRequestToJson(this);
}

@JsonSerializable()
class ResetPasswordRequest {
  final String email;
  final String newPassword;

  ResetPasswordRequest({required this.email, required this.newPassword});

  factory ResetPasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ResetPasswordRequestToJson(this);
}
