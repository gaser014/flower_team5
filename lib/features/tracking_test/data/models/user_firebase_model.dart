import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/user_entity.dart';

part 'user_firebase_model.g.dart';

class FCMTokenConverter
    implements JsonConverter<FCMTokenEntity, Map<String, dynamic>> {
  const FCMTokenConverter();

  @override
  FCMTokenEntity fromJson(Map<String, dynamic> json) {
    return FCMTokenEntity(
      token: json['token'] as String? ?? '',
      lang: json['lang'] as String? ?? '',
    );
  }

  @override
  Map<String, dynamic> toJson(FCMTokenEntity object) {
    return {'token': object.token, 'lang': object.lang};
  }
}

@JsonSerializable(explicitToJson: true)
@FCMTokenConverter()
class UserFirebaseModel extends UserEntity {
  const UserFirebaseModel({required super.userId, required super.fcmTokens})
    : super();

  factory UserFirebaseModel.fromJson(Map<String, dynamic> json) =>
      _$UserFirebaseModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserFirebaseModelToJson(this);

  factory UserFirebaseModel.fromEntity(UserEntity entity) {
    return UserFirebaseModel(
      userId: entity.userId,
      fcmTokens: entity.fcmTokens,
    );
  }
}
