import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/features/location/data/data_sources/location_local_data_source_contract.dart';
import 'package:flowers_app/features/location/data/data_sources/location_remote_data_source_contract.dart';
import 'package:flowers_app/features/location/domain/entities/location_entity.dart';
import 'package:flowers_app/features/location/domain/repositories/location_repository.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: LocationRepository)
class LocationRepositoryImpl implements LocationRepository {
  final LocationRemoteDataSourceContract _remoteDataSource;
  final LocationLocalDataSourceContract _localDataSource;

  LocationRepositoryImpl(this._remoteDataSource, this._localDataSource);

  @override
  Future<Result<bool>> requestLocationPermission() {
    return _remoteDataSource.requestLocationPermission();
  }

  @override
  Future<Result<bool>> isLocationPermissionGranted() {
    return _remoteDataSource.isLocationPermissionGranted();
  }

  @override
  Future<Result<LocationEntity>> getCurrentLocation() async {
    final result = await _remoteDataSource.getCurrentLocation();
    return result.when(
      success: (dto) {
        if (dto == null) {
          return Error(exception: Exception('Location data is null'));
        }
        final entity = dto.toEntity();
        // Cache in background (fire and forget)
        _localDataSource.cacheLocation(dto);
        return Success(data: entity);
      },
      error: (exception) => Error(exception: exception),
    );
  }

  @override
  double calculateDistance({
    required double startLatitude,
    required double startLongitude,
    required double endLatitude,
    required double endLongitude,
  }) {
    return Geolocator.distanceBetween(
      startLatitude,
      startLongitude,
      endLatitude,
      endLongitude,
    );
  }
}
