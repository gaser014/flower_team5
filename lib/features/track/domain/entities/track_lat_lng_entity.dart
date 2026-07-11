import 'package:equatable/equatable.dart';

/// A simple geographic coordinate used across the order tracking feature.
///
/// Kept independent from any map SDK type so the domain layer stays pure. The
/// parsing helpers normalise the several shapes the driver app writes to
/// Firebase (nested `location`/`latLong` objects or flat `lat`/`lng`/`long`).
class TrackLatLngEntity extends Equatable {
  final double lat;
  final double lng;

  const TrackLatLngEntity({required this.lat, required this.lng});

  @override
  List<Object?> get props => [lat, lng];

  static double? _toDouble(dynamic value) {
    if (value == null) return null;
    if (value is num) return value.toDouble();
    if (value is String) return double.tryParse(value.trim());
    return null;
  }

  /// Parses a combined `"lat,long"` string (e.g. `"30.94,31.29"`).
  static TrackLatLngEntity? fromCombined(dynamic value) {
    if (value is! String) return null;
    final parts = value.split(',');
    if (parts.length != 2) return null;
    final lat = _toDouble(parts[0]);
    final lng = _toDouble(parts[1]);
    if (lat == null || lng == null) return null;
    return TrackLatLngEntity(lat: lat, lng: lng);
  }

  /// Best-effort parse from any of the supported shapes. Returns null when no
  /// valid coordinate can be extracted.
  static TrackLatLngEntity? fromDynamic(dynamic value) {
    if (value == null) return null;
    if (value is String) return fromCombined(value);
    if (value is Map) {
      // Nested object under `location` / `latLong`.
      final nested = value['location'] ?? value['latLong'] ?? value['latlong'];
      if (nested != null && nested != value) {
        final parsed = fromDynamic(nested);
        if (parsed != null) return parsed;
      }
      // Flat fields (Firebase uses `long`; others use `lng`/`longitude`).
      final lat = _toDouble(value['lat'] ?? value['latitude']);
      final lng = _toDouble(
        value['lng'] ?? value['long'] ?? value['longitude'],
      );
      if (lat != null && lng != null) {
        return TrackLatLngEntity(lat: lat, lng: lng);
      }
    }
    return null;
  }
}
