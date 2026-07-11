import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract class AppEnv {
  AppEnv._();

  static String get googleMapsKey => _clean(_lookup('google_map_key'));

  static String? _lookup(String name) {
    final lower = name.toLowerCase();
    for (final entry in dotenv.env.entries) {
      if (entry.key.toLowerCase() == lower) return entry.value;
    }
    return null;
  }

  static String _clean(String? value) {
    if (value == null) return '';
    var result = value.trim();
    if (result.length >= 2) {
      final first = result[0];
      final last = result[result.length - 1];
      if ((first == '"' && last == '"') || (first == "'" && last == "'")) {
        result = result.substring(1, result.length - 1);
      }
    }
    return result.trim();
  }
}
