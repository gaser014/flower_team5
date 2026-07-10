import 'dart:convert';
import 'dart:developer';
import 'package:flutter/services.dart' show rootBundle;

class GovernorateItem {
  final String id;
  final String nameEn;
  final String nameAr;

  const GovernorateItem({
    required this.id,
    required this.nameEn,
    required this.nameAr,
  });
}

class AreaItem {
  final String id;
  final String governorateId;
  final String nameEn;
  final String nameAr;

  const AreaItem({
    required this.id,
    required this.governorateId,
    required this.nameEn,
    required this.nameAr,
  });
}

class EgyptLocationLoader {
  EgyptLocationLoader._();

  static List<GovernorateItem>? _governoratesCache;
  static List<AreaItem>? _areasCache;

  static Future<List<GovernorateItem>> loadGovernorates() async {
    if (_governoratesCache != null) return _governoratesCache!;

    final rows = await _loadTable(
      asset: 'assets/json/cities.json',
      tableName: 'governorates',
    );

    _governoratesCache = rows
        .map(
          (m) => GovernorateItem(
            id: m['id']?.toString() ?? '',
            nameEn: m['governorate_name_en']?.toString() ?? '',
            nameAr: m['governorate_name_ar']?.toString() ?? '',
          ),
        )
        .toList();
    return _governoratesCache!;
  }

  static Future<List<AreaItem>> loadAreas() async {
    if (_areasCache != null) return _areasCache!;

    final rows = await _loadTable(
      asset: 'assets/json/states.json',
      tableName: 'cities',
    );

    _areasCache = rows
        .map(
          (m) => AreaItem(
            id: m['id']?.toString() ?? '',
            governorateId: m['governorate_id']?.toString() ?? '',
            nameEn: m['city_name_en']?.toString() ?? '',
            nameAr: m['city_name_ar']?.toString() ?? '',
          ),
        )
        .toList();
    return _areasCache!;
  }

  static Future<List<Map<String, dynamic>>> _loadTable({
    required String asset,
    required String tableName,
  }) async {
    try {
      final raw = await rootBundle.loadString(asset);
      final parsed = jsonDecode(raw) as List;

      final dataMap = parsed.firstWhere(
        (item) => item['type'] == 'table' && item['name'] == tableName,
        orElse: () => <String, dynamic>{},
      );

      return (dataMap['data'] as List? ?? []).cast<Map<String, dynamic>>();
    } catch (e, s) {
      log(
        'EgyptLocationLoader: failed to load "$tableName" from $asset',
        error: e,
        stackTrace: s,
        name: 'EgyptLocationLoader',
      );
      return const [];
    }
  }
}
