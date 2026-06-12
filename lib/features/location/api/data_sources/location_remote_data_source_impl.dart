import 'dart:developer';

import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/features/location/data/data_sources/location_remote_data_source_contract.dart';
import 'package:flowers_app/features/location/data/models/location_dto.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: LocationRemoteDataSourceContract)
class LocationRemoteDataSourceImpl implements LocationRemoteDataSourceContract {
  @override
  Future<Result<bool>> requestLocationPermission() async {
    try {
      log('🔵 [LocationRemoteDataSource] Starting permission request...');

      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      log(
        '🔵 [LocationRemoteDataSource] Location services enabled: $serviceEnabled',
      );

      if (!serviceEnabled) {
        log('� [LocationRemoteDataSource] Location services are disabled');
        return Success(data: false);
      }

      // Check current permission status
      LocationPermission permission = await Geolocator.checkPermission();
      log('🔵 [LocationRemoteDataSource] Current permission: $permission');

      if (permission == LocationPermission.denied) {
        log('🔵 [LocationRemoteDataSource] Permission denied, requesting...');
        permission = await Geolocator.requestPermission();
        log(
          '🔵 [LocationRemoteDataSource] Permission request result: $permission',
        );
      }

      if (permission == LocationPermission.deniedForever) {
        log('🔴 [LocationRemoteDataSource] Permission denied forever');
        return Success(data: false);
      }

      final isGranted =
          permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always;
      log('� [LocationRemoteDataSource] Is granted: $isGranted');

      return Success(data: isGranted);
    } catch (e) {
      log('🔴 [LocationRemoteDataSource] Error requesting permission: $e');
      return Error(exception: Exception(e.toString()));
    }
  }

  @override
  Future<Result<bool>> isLocationPermissionGranted() async {
    try {
      final permission = await Geolocator.checkPermission();
      final isGranted =
          permission == LocationPermission.whileInUse ||
          permission == LocationPermission.always;
      return Success(data: isGranted);
    } catch (e) {
      return Error(exception: Exception(e.toString()));
    }
  }

  @override
  Future<Result<LocationDto>> getCurrentLocation() async {
    try {
      final bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return Error(exception: Exception('Location services are disabled.'));
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return Error(exception: Exception('Location permissions are denied'));
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return Error(
          exception: Exception('Location permissions are permanently denied'),
        );
      }

      final Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 10,
        ),
      );

      return Success(
        data: LocationDto(
          latitude: position.latitude,
          longitude: position.longitude,
        ),
      );
    } catch (e) {
      return Error(exception: Exception(e.toString()));
    }
  }
}
