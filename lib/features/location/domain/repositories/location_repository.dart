import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/features/location/domain/entities/location_entity.dart';

abstract interface class LocationRepository {
  Future<Result<bool>> requestLocationPermission();

  Future<Result<bool>> isLocationPermissionGranted();

  Future<Result<LocationEntity>> getCurrentLocation();

  double calculateDistance({
    required double startLatitude,
    required double startLongitude,
    required double endLatitude,
    required double endLongitude,
  });
}
