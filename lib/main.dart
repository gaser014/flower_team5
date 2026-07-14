import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flowers_app/app.dart'as app;
import 'package:flowers_app/config/database/cache_helper.dart';
import 'package:flowers_app/config/fcm/fcm_service.dart';
import 'package:flowers_app/config/helper/bloc_observer.dart';
import 'package:flowers_app/config/remote_config/remote_config_service.dart';
import 'package:flowers_app/core/constants/app_constants.dart';
import 'package:flowers_app/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'config/dependency_injection/di.dart';
import 'package:firebase_core/firebase_core.dart';

//flutter pub run build_runner build --delete-conflicting-outputs
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  await AppSharedPreferences.initialSharedPreference();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await RemoteConfigService.instance.initialize();
  await EasyLocalization.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  FCMService().initialize();
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  // Initialize notification badge service
  // await getIt.get<NotificationBadgeService>().initialize();

  // SystemChrome.setSystemUIOverlayStyle(
  //   const SystemUiOverlayStyle(
  //     statusBarColor: Colors.transparent,
  //     statusBarIconBrightness: Brightness.dark,
  //     systemNavigationBarColor: Colors.white,
  //     systemNavigationBarIconBrightness: Brightness.dark,
  //   ),
  // );

  runApp(
    EasyLocalization(
      startLocale: AppConstants.englishLocale,
      supportedLocales: const [AppConstants.englishLocale, AppConstants.arabicLocale],
      path: AppConstants.translationPath,
      fallbackLocale: AppConstants.arabicLocale,
      child: const app.MyApp(),
    ),
  );

  WidgetsBinding.instance.addPostFrameCallback((_) async {
    // Temporarily disable Firebase for testing
    // if (!kIsWeb && defaultTargetPlatform != TargetPlatform.windows) {
    //   await FirebaseNotifications.initializeFirebase(role: null);
    // }
  });
}
