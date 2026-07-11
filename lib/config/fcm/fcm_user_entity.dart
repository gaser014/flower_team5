/// A user's stored FCM tokens (mirrors the shape used by the driver app so the
/// two apps can notify each other through the shared `users` collection).
class FcmUserEntity {
  final String userId;
  final List<FCMTokenEntity> fcmTokens;

  const FcmUserEntity({required this.userId, required this.fcmTokens});
}

class FCMTokenEntity {
  final String token;
  final String lang;

  const FCMTokenEntity({required this.token, this.lang = 'en'});
}
