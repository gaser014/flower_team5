import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:injectable/injectable.dart';
import 'package:logger/logger.dart';

@module
abstract class InjectableModule {
  @lazySingleton
  Logger get logger => Logger();

  @lazySingleton
  FirebaseRemoteConfig get firebaseRemoteConfig =>
      FirebaseRemoteConfig.instance;
}
