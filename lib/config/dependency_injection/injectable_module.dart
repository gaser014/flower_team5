import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flowers_app/config/fcm/fcm_service.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

@module
abstract class InjectableModule {
  @lazySingleton
  Logger get logger => Logger();

  @lazySingleton
  FirebaseRemoteConfig get firebaseRemoteConfig =>
      FirebaseRemoteConfig.instance;

  /// FCMService is a singleton; expose it to DI so data sources can depend on it.
  @lazySingleton
  FCMService get fcmService => FCMService();
}
