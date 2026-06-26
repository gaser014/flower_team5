class UserEntity {
  final String userId;
  final String fcmToken;
  final String language;

  const UserEntity({
    required this.userId,
    required this.fcmToken,
    required this.language,
  });
}
