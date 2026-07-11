import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flowers_app/config/remote_config/remote_config_service.dart';
import 'package:flowers_app/config/uses_cases/use_cases.dart';
import 'package:flowers_app/features/addresses/data/models/address_dto.dart';
import 'package:flowers_app/features/addresses/domain/entities/address_entity.dart';
import 'package:flowers_app/features/addresses/domain/use_cases/get_addresses.dart';
import 'package:flowers_app/features/addresses/domain/use_cases/get_nearest_address.dart';
import 'package:flowers_app/features/location/domain/use_cases/get_current_location.dart';
import 'package:flowers_app/features/location/domain/use_cases/request_location_permission.dart';
import 'package:flowers_app/features/location/presentation/cubit/location_states.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class LocationCubit extends Cubit<LocationState> {
  final RequestLocationPermissionUseCase _requestLocationPermissionUseCase;
  final GetCurrentLocationUseCase _getCurrentLocationUseCase;
  final GetAddressesUseCase _getAddressesUseCase;
  final GetNearestAddressUseCase _getNearestAddressUseCase;

  LocationCubit(
    this._requestLocationPermissionUseCase,
    this._getCurrentLocationUseCase,
    this._getAddressesUseCase,
    this._getNearestAddressUseCase,
  ) : super(LocationInitial());

  /// Initialize home location on app start
  Future<void> initializeHomeLocation() async {
    log('🌍 [LocationCubit] Initializing home location...');
    emit(LocationLoading());

    log('🔵 [LocationCubit] Requesting location permission...');
    final permissionResult = await _requestLocationPermissionUseCase(
      const NoParams(),
    );

    permissionResult.when(
      success: (isGranted) async {
        log('🔵 [LocationCubit] Permission result: $isGranted');
        if (isGranted == true) {
          log('🟢 [LocationCubit] Permission granted, handling...');
          await _handleLocationPermissionGranted();
        } else {
          log('🔴 [LocationCubit] Permission denied, handling...');
          await _handleLocationPermissionDenied();
        }
      },
      error: (exception) {
        log('🔴 [LocationCubit] Permission error: $exception');
        emit(LocationError(message: exception?.toString() ?? 'Unknown error'));
      },
    );
  }

  /// Handle case when location permission is granted
  Future<void> _handleLocationPermissionGranted() async {
    log('🟢 [LocationCubit] Handling permission granted...');
    final locationResult = await _getCurrentLocationUseCase(const NoParams());

    locationResult.when(
      success: (currentLocation) async {
        if (currentLocation == null) {
          log('🔴 [LocationCubit] Failed to get current location');
          emit(const LocationError(message: 'Failed to get current location'));
          return;
        }

        log(
          '🟢 [LocationCubit] Got current location: ${currentLocation.latitude}, ${currentLocation.longitude}',
        );

        final addressesResult = await _getAddressesUseCase(const NoParams());

        addressesResult.when(
          success: (addresses) async {
            log(
              '🔵 [LocationCubit] Retrieved addresses from API: ${addresses?.length ?? 0}',
            );

            if (addresses == null || addresses.isEmpty) {
              log(
                '🟡 [LocationCubit] No addresses from API, trying Firebase Remote Config...',
              );
              await _handleNoAddressesFound();
              return;
            }

            final nearestAddressResult = await _getNearestAddressUseCase(
              GetNearestAddressParams(
                currentLocation: currentLocation,
                addresses: addresses,
              ),
            );

            nearestAddressResult.when(
              success: (nearestAddress) {
                if (nearestAddress != null) {
                  log(
                    '🟢 [LocationCubit] Selected nearest address: ${nearestAddress.street}',
                  );
                  emit(
                    LocationLoaded(
                      selectedAddress: nearestAddress,
                      allAddresses: addresses,
                      isFromLocation: true,
                    ),
                  );
                } else {
                  log('🟡 [LocationCubit] No valid addresses found');
                  emit(
                    const LocationEmpty(message: 'No valid addresses found'),
                  );
                }
              },
              error: (exception) {
                log(
                  '🔴 [LocationCubit] Error finding nearest address: $exception',
                );
                emit(
                  LocationError(
                    message: exception?.toString() ?? 'Unknown error',
                  ),
                );
              },
            );
          },
          error: (exception) {
            log('🔴 [LocationCubit] Error getting addresses: $exception');
            emit(
              LocationError(message: exception?.toString() ?? 'Unknown error'),
            );
          },
        );
      },
      error: (exception) {
        log('🔴 [LocationCubit] Error getting location: $exception');
        emit(LocationError(message: exception?.toString() ?? 'Unknown error'));
      },
    );
  }

  /// Handle case when no addresses found (fallback to Firebase Remote Config)
  Future<void> _handleNoAddressesFound() async {
    log('🔵 [LocationCubit] Handling no addresses found...');

    // Try to get address from Firebase Remote Config
    final remoteConfigAddress = RemoteConfigService.instance.address;
    log('🔵 [LocationCubit] Address from Remote Config: $remoteConfigAddress');

    if (remoteConfigAddress != null && remoteConfigAddress.isNotEmpty) {
      try {
        // Parse address from Remote Config
        final addressDto = AddressDto.fromJson(remoteConfigAddress);
        final addressEntity = addressDto.toEntity();

        log(
          '🟢 [LocationCubit] Using address from Remote Config: ${addressEntity.street}, ${addressEntity.city}',
        );

        emit(
          LocationLoaded(
            selectedAddress: addressEntity,
            allAddresses: [addressEntity],
            isFromLocation: false,
          ),
        );
        return;
      } catch (e) {
        log('🔴 [LocationCubit] Error parsing Remote Config address: $e');
      }
    }

    log('🟡 [LocationCubit] No address in Remote Config');
    emit(const LocationEmpty(message: 'No saved addresses found'));
  }

  /// Handle case when location permission is denied
  Future<void> _handleLocationPermissionDenied() async {
    log('🔴 [LocationCubit] Handling permission denied...');

    // Try to get address from Firebase Remote Config first
    final remoteConfigAddress = RemoteConfigService.instance.address;
    log('🔵 [LocationCubit] Address from Remote Config: $remoteConfigAddress');

    if (remoteConfigAddress != null && remoteConfigAddress.isNotEmpty) {
      try {
        // Parse address from Remote Config
        final addressDto = AddressDto.fromJson(remoteConfigAddress);
        final addressEntity = addressDto.toEntity();

        log(
          '🟢 [LocationCubit] Using address from Remote Config: ${addressEntity.street}, ${addressEntity.city}',
        );

        emit(
          LocationLoaded(
            selectedAddress: addressEntity,
            allAddresses: [addressEntity],
            isFromLocation: false,
          ),
        );
        return;
      } catch (e) {
        log('🔴 [LocationCubit] Error parsing Remote Config address: $e');
      }
    }

    // Fallback: Try to get addresses from API
    final addressesResult = await _getAddressesUseCase(const NoParams());

    addressesResult.when(
      success: (addresses) {
        log(
          '🔵 [LocationCubit] Retrieved addresses from API: ${addresses?.length ?? 0}',
        );
        if (addresses == null || addresses.isEmpty) {
          log('🟡 [LocationCubit] No saved addresses found');
          emit(
            const LocationEmpty(
              message: 'No saved addresses. Please add an address first.',
            ),
          );
          return;
        }

        // Use first address as fallback
        log('🟡 [LocationCubit] Using first address from API');
        emit(
          LocationLoaded(
            selectedAddress: addresses.first,
            allAddresses: addresses,
            isFromLocation: false,
          ),
        );
      },
      error: (exception) {
        log('🔴 [LocationCubit] Error getting addresses: $exception');
        emit(LocationError(message: exception?.toString() ?? 'Unknown error'));
      },
    );
  }

  /// Manually select an address
  void selectAddress(AddressEntity address) {
    if (state is LocationLoaded) {
      final currentState = state as LocationLoaded;
      emit(currentState.copyWith(selectedAddress: address));
    }
  }

  /// Refresh
  Future<void> refresh() async {
    await initializeHomeLocation();
  }
}
