import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/user_entity.dart';
import 'location_model.dart';

part 'user_firebase_model.g.dart';

@JsonSerializable(explicitToJson: true)
class UserFirebaseModel extends UserEntity {
  UserFirebaseModel({
    required super.userId,
    required super.fcmToken,
    required super.language,
  }) : super();

  factory UserFirebaseModel.fromJson(Map<String, dynamic> json) =>
      _$UserFirebaseModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserFirebaseModelToJson(this);

  factory UserFirebaseModel.fromEntity(UserEntity entity) {
    return UserFirebaseModel(
      userId: entity.userId,
      fcmToken: entity.fcmToken,
      language: entity.language,
    );
  }
}
