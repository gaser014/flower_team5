import 'package:json_annotation/json_annotation.dart';

part 'reset_password_request.g.dart';

@JsonSerializable()
class ResetPasswordRequest {
  @JsonKey(name: 'password')
  final String currentPassword;
  
  @JsonKey(name: 'newPassword')
  final String newPassword;

  ResetPasswordRequest({
    required this.currentPassword,
    required this.newPassword,
  });

  Map<String, dynamic> toJson() => _$ResetPasswordRequestToJson(this);
}
