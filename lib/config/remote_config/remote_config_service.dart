import 'dart:convert';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:logger/logger.dart';

/// Service that wraps [FirebaseRemoteConfig] and exposes typed getters
/// for every parameter defined in the Firebase console.
class RemoteConfigService {
  RemoteConfigService._();

  static final RemoteConfigService _instance = RemoteConfigService._();

  /// Singleton accessor.
  static RemoteConfigService get instance => _instance;

  final FirebaseRemoteConfig _remoteConfig = FirebaseRemoteConfig.instance;
  final Logger _logger = Logger();

  // ------------------------------------------------------------------
  // Keys – keep in sync with the Firebase console parameter names.
  // ------------------------------------------------------------------
  static const String _kAddress = 'address';

  // ------------------------------------------------------------------
  // Public API
  // ------------------------------------------------------------------

  /// Fetches the latest config from Firebase and activates it.
  ///
  /// Call this once during app startup (after `Firebase.initializeApp()`).
  Future<void> initialize() async {
    try {
      // Reasonable defaults for a production app.
      await _remoteConfig.setConfigSettings(
        RemoteConfigSettings(
          fetchTimeout: const Duration(seconds: 10),
          minimumFetchInterval: const Duration(hours: 1),
        ),
      );

      // Set in-app default values so the app works even before the first
      // successful fetch (e.g. no network).
      await _remoteConfig.setDefaults(_defaults);

      await _remoteConfig.fetchAndActivate();
      _logger.i('RemoteConfig fetched and activated successfully.');
    } catch (e, stack) {
      _logger.e('RemoteConfig fetch failed', error: e, stackTrace: stack);
    }
  }

  // ------------------------------------------------------------------
  // Typed getters
  // ------------------------------------------------------------------

  /// Returns the raw JSON string stored under the `address` key.
  String get addressJson => _remoteConfig.getString(_kAddress);

  /// Returns the `address` value decoded as a JSON object (Map).
  ///
  /// Returns `null` when the string is empty or cannot be parsed.
  Map<String, dynamic>? get address {
    final raw = addressJson;
    if (raw.isEmpty) return null;
    try {
      final decoded = jsonDecode(raw);
      if (decoded is Map<String, dynamic>) {
        return decoded;
      }
      return null;
    } catch (e) {
      _logger.e('Failed to parse address JSON', error: e);
      return null;
    }
  }

  // ------------------------------------------------------------------
  // Helpers
  // ------------------------------------------------------------------

  static const Map<String, dynamic> _defaults = {_kAddress: '{}'};
}
