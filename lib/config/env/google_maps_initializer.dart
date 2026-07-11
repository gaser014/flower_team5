import 'dart:developer';
import 'dart:io';

import 'package:flowers_app/config/env/app_env.dart';
import 'package:flutter/services.dart';

abstract class GoogleMapsInitializer {
  static const MethodChannel _channel = MethodChannel('app/google_maps');

  static Future<void> configureIfNeeded() async {
    if (!Platform.isIOS) return;

    final key = AppEnv.googleMapsKey;
    if (key.isEmpty) {
      log('Google Maps key missing in .env', name: 'GoogleMapsInitializer');
      return;
    }

    try {
      await _channel.invokeMethod<void>('setApiKey', key);
    } catch (e) {
      log(
        'Failed to set iOS Google Maps key: $e',
        name: 'GoogleMapsInitializer',
      );
    }
  }
}
