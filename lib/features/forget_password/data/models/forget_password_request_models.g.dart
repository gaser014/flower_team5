// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'forget_password_request_models.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ForgetPasswordRequest _$ForgetPasswordRequestFromJson(
  Map<String, dynamic> json,
) => ForgetPasswordRequest(email: json['email'] as String);

Map<String, dynamic> _$ForgetPasswordRequestToJson(
  ForgetPasswordRequest instance,
) => <String, dynamic>{'email': instance.email};

VerifyCodeRequest _$VerifyCodeRequestFromJson(Map<String, dynamic> json) =>
    VerifyCodeRequest(resetCode: json['resetCode'] as String);

Map<String, dynamic> _$VerifyCodeRequestToJson(VerifyCodeRequest instance) =>
    <String, dynamic>{'resetCode': instance.resetCode};

ResetPasswordRequest _$ResetPasswordRequestFromJson(
  Map<String, dynamic> json,
) => ResetPasswordRequest(
  email: json['email'] as String,
  newPassword: json['newPassword'] as String,
);

Map<String, dynamic> _$ResetPasswordRequestToJson(
  ResetPasswordRequest instance,
) => <String, dynamic>{
  'email': instance.email,
  'newPassword': instance.newPassword,
};
