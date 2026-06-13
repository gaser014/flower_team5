import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

class CityItem {
  final String id;
  final String nameEn;
  final String nameAr;

  const CityItem({
    required this.id,
    required this.nameEn,
    required this.nameAr,
  });
}

class AreaItem {
  final String id;
  final String cityId;
  final String nameEn;
  final String nameAr;

  const AreaItem({
    required this.id,
    required this.cityId,
    required this.nameEn,
    required this.nameAr,
  });
}

class EgyptLocationLoader {
  EgyptLocationLoader._();

  static List<CityItem>? _citiesCache;
  static List<AreaItem>? _areasCache;

  static Future<List<CityItem>> loadCities() async {
    if (_citiesCache != null) return _citiesCache!;

    try {
      final raw = await rootBundle.loadString('assets/json/cities.json');
      final parsed = jsonDecode(raw) as List;

      // Find the data array in the structure
      final dataMap = parsed.firstWhere(
        (item) => item['type'] == 'table' && item['name'] == 'governorates',
        orElse: () => {},
      );

      final list = (dataMap['data'] as List? ?? [])
          .cast<Map<String, dynamic>>();

      _citiesCache = list
          .map(
            (m) => CityItem(
              id: m['id']?.toString() ?? '',
              nameEn: m['governorate_name_en']?.toString() ?? '',
              nameAr: m['governorate_name_ar']?.toString() ?? '',
            ),
          )
          .toList();
      return _citiesCache!;
    } catch (e) {
      // Return empty list if file doesn't exist or has wrong format
      _citiesCache = [];
      return _citiesCache!;
    }
  }

  static Future<List<AreaItem>> loadAreas() async {
    if (_areasCache != null) return _areasCache!;

    try {
      final raw = await rootBundle.loadString('assets/json/states.json');
      final parsed = jsonDecode(raw) as List;

      // Find the data array in the structure
      final dataMap = parsed.firstWhere(
        (item) => item['type'] == 'table' && item['name'] == 'cities',
        orElse: () => {},
      );

      final list = (dataMap['data'] as List? ?? [])
          .cast<Map<String, dynamic>>();

      _areasCache = list
          .map(
            (m) => AreaItem(
              id: m['id']?.toString() ?? '',
              cityId: m['governorate_id']?.toString() ?? '',
              nameEn: m['city_name_en']?.toString() ?? '',
              nameAr: m['city_name_ar']?.toString() ?? '',
            ),
          )
          .toList();
      return _areasCache!;
    } catch (e) {
      // Return empty list if file doesn't exist or has wrong format
      _areasCache = [];
      return _areasCache!;
    }
  }
}
