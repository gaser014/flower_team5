import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/features/addresses/domain/entities/address_entity.dart';
import 'package:flowers_app/features/addresses/domain/use_cases/get_nearest_address.dart';
import 'package:flowers_app/features/location/domain/entities/location_entity.dart';
import 'package:flowers_app/features/location/domain/repositories/location_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_nearest_address_test.mocks.dart';

@GenerateMocks([LocationRepository])
void main() {
  late GetNearestAddressUseCase useCase;
  late MockLocationRepository mockLocationRepository;

  setUp(() {
    mockLocationRepository = MockLocationRepository();
    useCase = GetNearestAddressUseCase(mockLocationRepository);
  });

  const tCurrentLocation = LocationEntity(
    latitude: 30.0444,
    longitude: 31.2357,
  );

  const tAddress1 = AddressEntity(
    id: '1',
    lat: '30.0500',
    long: '31.2400',
    street: 'Near St',
    city: 'Cairo',
  );

  const tAddress2 = AddressEntity(
    id: '2',
    lat: '31.2000',
    long: '29.9000',
    street: 'Far St',
    city: 'Alexandria',
  );

  const tAddress3 = AddressEntity(
    id: '3',
    lat: null,
    long: null,
    street: 'No Coords',
  );

  group('call', () {
    test('should return null when addresses list is empty', () async {
      final params = GetNearestAddressParams(
        currentLocation: tCurrentLocation,
        addresses: [],
      );

      final result = await useCase(params);

      expect(result, isA<Success<AddressEntity?>>());
      final successResult = result as Success<AddressEntity?>;
      expect(successResult.data, isNull);
    });

    test('should return the nearest address from multiple', () async {
      when(
        mockLocationRepository.calculateDistance(
          startLatitude: anyNamed('startLatitude'),
          startLongitude: anyNamed('startLongitude'),
          endLatitude: anyNamed('endLatitude'),
          endLongitude: anyNamed('endLongitude'),
        ),
      ).thenAnswer((invocation) {
        final endLat = invocation.namedArguments[#endLatitude] as double;
        final endLng = invocation.namedArguments[#endLongitude] as double;
        // Address1 is near currentLocation, address2 is far
        if (endLat == 30.0500 && endLng == 31.2400) return 1.0;
        if (endLat == 31.2000 && endLng == 29.9000) return 200.0;
        return 999.0;
      });

      final params = GetNearestAddressParams(
        currentLocation: tCurrentLocation,
        addresses: [tAddress1, tAddress2],
      );

      final result = await useCase(params);

      expect(result, isA<Success<AddressEntity?>>());
      final successResult = result as Success<AddressEntity?>;
      expect(successResult.data, tAddress1);
    });

    test('should skip addresses with null lat/long', () async {
      when(
        mockLocationRepository.calculateDistance(
          startLatitude: anyNamed('startLatitude'),
          startLongitude: anyNamed('startLongitude'),
          endLatitude: anyNamed('endLatitude'),
          endLongitude: anyNamed('endLongitude'),
        ),
      ).thenReturn(1.0);

      final params = GetNearestAddressParams(
        currentLocation: tCurrentLocation,
        addresses: [tAddress3, tAddress1],
      );

      final result = await useCase(params);

      expect(result, isA<Success<AddressEntity?>>());
      final successResult = result as Success<AddressEntity?>;
      expect(successResult.data, tAddress1);
    });

    test('should skip addresses with invalid lat/long strings', () async {
      const invalidLat = AddressEntity(id: '4', lat: 'invalid', long: '31.0');
      const validAddress = AddressEntity(id: '5', lat: '30.0', long: '31.0');

      when(
        mockLocationRepository.calculateDistance(
          startLatitude: anyNamed('startLatitude'),
          startLongitude: anyNamed('startLongitude'),
          endLatitude: anyNamed('endLatitude'),
          endLongitude: anyNamed('endLongitude'),
        ),
      ).thenReturn(5.0);

      final params = GetNearestAddressParams(
        currentLocation: tCurrentLocation,
        addresses: [invalidLat, validAddress],
      );

      final result = await useCase(params);

      expect(result, isA<Success<AddressEntity?>>());
      final successResult = result as Success<AddressEntity?>;
      expect(successResult.data, validAddress);
    });

    test('should return null when all addresses have no valid coordinates',
        () async {
      final params = GetNearestAddressParams(
        currentLocation: tCurrentLocation,
        addresses: [tAddress3],
      );

      final result = await useCase(params);

      expect(result, isA<Success<AddressEntity?>>());
      final successResult = result as Success<AddressEntity?>;
      expect(successResult.data, isNull);
    });

    test('should return Error when exception is thrown', () async {
      when(
        mockLocationRepository.calculateDistance(
          startLatitude: anyNamed('startLatitude'),
          startLongitude: anyNamed('startLongitude'),
          endLatitude: anyNamed('endLatitude'),
          endLongitude: anyNamed('endLongitude'),
        ),
      ).thenThrow(Exception('Calculation error'));

      final params = GetNearestAddressParams(
        currentLocation: tCurrentLocation,
        addresses: [tAddress1],
      );

      final result = await useCase(params);

      expect(result, isA<Error<AddressEntity?>>());
    });

    test('should return single address when only one valid address exists',
        () async {
      when(
        mockLocationRepository.calculateDistance(
          startLatitude: anyNamed('startLatitude'),
          startLongitude: anyNamed('startLongitude'),
          endLatitude: anyNamed('endLatitude'),
          endLongitude: anyNamed('endLongitude'),
        ),
      ).thenReturn(10.0);

      final params = GetNearestAddressParams(
        currentLocation: tCurrentLocation,
        addresses: [tAddress1],
      );

      final result = await useCase(params);

      expect(result, isA<Success<AddressEntity?>>());
      final successResult = result as Success<AddressEntity?>;
      expect(successResult.data, tAddress1);
    });
  });

  group('GetNearestAddressParams', () {
    test('should have correct props', () {
      final params = GetNearestAddressParams(
        currentLocation: tCurrentLocation,
        addresses: [tAddress1],
      );
      expect(params.props, [tCurrentLocation, [tAddress1]]);
    });

    test('should support value equality', () {
      final params1 = GetNearestAddressParams(
        currentLocation: tCurrentLocation,
        addresses: [tAddress1],
      );
      final params2 = GetNearestAddressParams(
        currentLocation: tCurrentLocation,
        addresses: [tAddress1],
      );
      expect(params1, params2);
    });

    test('should not be equal when addresses differ', () {
      final params1 = GetNearestAddressParams(
        currentLocation: tCurrentLocation,
        addresses: [tAddress1],
      );
      final params2 = GetNearestAddressParams(
        currentLocation: tCurrentLocation,
        addresses: [tAddress2],
      );
      expect(params1, isNot(params2));
    });
  });
}
