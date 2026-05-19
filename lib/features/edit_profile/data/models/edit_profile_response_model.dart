import 'package:flowers_app/features/login/data/models/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'edit_profile_response_model.g.dart';

@JsonSerializable()
class EditProfileResponseModel {
  @JsonKey(name: "message")
  final String? message;
  
  @JsonKey(name: "user")
  final UserModel? user;

  const EditProfileResponseModel({this.message, this.user});

  factory EditProfileResponseModel.fromJson(Map<String, dynamic> json) =>
      _$EditProfileResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$EditProfileResponseModelToJson(this);
}
