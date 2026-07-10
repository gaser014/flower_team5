import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/features/location/data/models/location_dto.dart';

abstract interface class LocationRemoteDataSourceContract {
  Future<Result<bool>> requestLocationPermission();

  Future<Result<bool>> isLocationPermissionGranted();

  Future<Result<LocationDto>> getCurrentLocation();
}
