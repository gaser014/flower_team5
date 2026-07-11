import 'dart:math' as math;

import 'package:equatable/equatable.dart';

class LatLngEntity extends Equatable {
  final double lat;
  final double lng;

  const LatLngEntity({required this.lat, required this.lng});

  @override
  List<Object?> get props => [lat, lng];

  static double? _toDouble(dynamic value) {
    if (value == null) return null;
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value.trim());
    return null;
  }

  static LatLngEntity? fromCombined(dynamic value) {
    if (value is! String) return null;
    final parts = value.split(',');
    if (parts.length != 2) return null;
    final lat = _toDouble(parts[0]);
    final lng = _toDouble(parts[1]);
    if (lat == null || lng == null) return null;
    return LatLngEntity(lat: lat, lng: lng);
  }

  static double distanceMeters(LatLngEntity a, LatLngEntity b) {
    const earthRadiusMeters = 6371000.0;
    double toRad(double deg) => deg * math.pi / 180.0;

    final dLat = toRad(b.lat - a.lat);
    final dLng = toRad(b.lng - a.lng);
    final lat1 = toRad(a.lat);
    final lat2 = toRad(b.lat);

    final h =
        math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.cos(lat1) *
            math.cos(lat2) *
            math.sin(dLng / 2) *
            math.sin(dLng / 2);
    return earthRadiusMeters * 2 * math.atan2(math.sqrt(h), math.sqrt(1 - h));
  }

  static LatLngEntity? fromDynamic(dynamic value) {
    if (value == null) return null;
    if (value is String) return fromCombined(value);
    if (value is Map) {
      final nested = value['location'] ?? value['latLong'] ?? value['latlong'];
      if (nested != null && nested != value) {
        final parsed = fromDynamic(nested);
        if (parsed != null) return parsed;
      }
      final lat = _toDouble(value['lat'] ?? value['latitude']);
      final lng = _toDouble(
        value['lng'] ?? value['long'] ?? value['longitude'],
      );
      if (lat != null && lng != null) return LatLngEntity(lat: lat, lng: lng);
    }
    return null;
  }
}
