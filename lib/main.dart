import 'package:easy_localization/easy_localization.dart';
import 'package:flowers_app/app.dart';
import 'package:flowers_app/config/database/cache_helper.dart';
import 'package:flowers_app/config/helper/bloc_observer.dart';
import 'package:flowers_app/core/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'config/dependency_injection/di.dart';

//flutter pub run build_runner build --delete-conflicting-outputs
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppSharedPreferences.initialSharedPreference();
  await EasyLocalization.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  configureDependencies();

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
      startLocale: const Locale('en', 'US'),
      supportedLocales: const [Locale('en', 'US'), Locale('ar', 'EG')],
      path: AppConstants.translationPath,
      fallbackLocale: const Locale('ar', 'EG'),
      child: const MyApp(),
    ),
  );

  WidgetsBinding.instance.addPostFrameCallback((_) async {
    // Temporarily disable Firebase for testing
    // if (!kIsWeb && defaultTargetPlatform != TargetPlatform.windows) {
    //   await FirebaseNotifications.initializeFirebase(role: null);
    // }
  });
}
