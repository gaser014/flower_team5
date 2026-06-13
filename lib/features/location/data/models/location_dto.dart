import 'package:flowers_app/features/location/domain/entities/location_entity.dart';

class LocationDto {
  final double latitude;
  final double longitude;

  const LocationDto({required this.latitude, required this.longitude});

  factory LocationDto.fromJson(Map<String, dynamic> json) {
    return LocationDto(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {'latitude': latitude, 'longitude': longitude};
  }

  factory LocationDto.fromEntity(LocationEntity entity) {
    return LocationDto(latitude: entity.latitude, longitude: entity.longitude);
  }

  LocationEntity toEntity() {
    return LocationEntity(latitude: latitude, longitude: longitude);
  }
}
