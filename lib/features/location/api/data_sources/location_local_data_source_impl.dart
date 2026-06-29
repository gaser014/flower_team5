import 'dart:convert';

import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/features/location/data/data_sources/location_local_data_source_contract.dart';
import 'package:flowers_app/features/location/data/models/location_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@Injectable(as: LocationLocalDataSourceContract)
class LocationLocalDataSourceImpl implements LocationLocalDataSourceContract {
  static const String _kCachedLocation = 'cached_location';

  @override
  Future<Result<LocationDto?>> getCachedLocation() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final jsonString = prefs.getString(_kCachedLocation);
      if (jsonString == null) return const Success(data: null);

      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      return Success(data: LocationDto.fromJson(json));
    } catch (e) {
      return Error(exception: Exception(e.toString()));
    }
  }

  @override
  Future<Result<void>> cacheLocation(LocationDto location) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_kCachedLocation, jsonEncode(location.toJson()));
      return const Success(data: null);
    } catch (e) {
      return Error(exception: Exception(e.toString()));
    }
  }

  @override
  Future<Result<void>> clearCachedLocation() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_kCachedLocation);
      return const Success(data: null);
    } catch (e) {
      return Error(exception: Exception(e.toString()));
    }
  }
}
