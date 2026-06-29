import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/features/location/data/models/location_dto.dart';

abstract interface class LocationLocalDataSourceContract {
  Future<Result<LocationDto?>> getCachedLocation();

  Future<Result<void>> cacheLocation(LocationDto location);

  Future<Result<void>> clearCachedLocation();
}
