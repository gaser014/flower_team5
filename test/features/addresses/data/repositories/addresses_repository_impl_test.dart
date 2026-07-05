import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/features/addresses/data/data_sources/addresses_remote_data_source_contract.dart';
import 'package:flowers_app/features/addresses/data/models/address_dto.dart';
import 'package:flowers_app/features/addresses/data/models/addresses_response_dto.dart';
import 'package:flowers_app/features/addresses/data/repositories/addresses_repository_impl.dart';
import 'package:flowers_app/features/addresses/domain/entities/address_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'addresses_repository_impl_test.mocks.dart';

@GenerateMocks([AddressesRemoteDataSourceContract])
void main() {
  provideDummy<Result<AddressesResponseDto>>(
    const Success<AddressesResponseDto>(),
  );

  late AddressesRepositoryImpl repository;
  late MockAddressesRemoteDataSourceContract mockDataSource;

  final tAddressDto = AddressDto(
    id: '1',
    street: '123 Main St',
    phone: '01010700700',
    city: 'Cairo',
    lat: '30.0444',
    long: '31.2357',
    username: 'ahmed',
  );

  final tAddressEntity = AddressEntity(
    id: '1',
    street: '123 Main St',
    phone: '01010700700',
    city: 'Cairo',
    lat: '30.0444',
    long: '31.2357',
    username: 'ahmed',
  );

  final tResponseDto = AddressesResponseDto(
    message: 'success',
    addresses: [tAddressDto],
  );

  setUp(() {
    mockDataSource = MockAddressesRemoteDataSourceContract();
    repository = AddressesRepositoryImpl(
      addressesRemoteDataSourceContract: mockDataSource,
    );
  });

  group('getAddresses', () {
    test('should return Success with entities when remote data source succeeds',
        () async {
      when(mockDataSource.getAddresses()).thenAnswer(
        (_) async => Success<AddressesResponseDto>(data: tResponseDto),
      );

      final result = await repository.getAddresses();

      expect(result, isA<Success<List<AddressEntity>>>());
      final successResult = result as Success<List<AddressEntity>>;
      expect(successResult.data, hasLength(1));
      expect(successResult.data!.first.id, '1');
      verify(mockDataSource.getAddresses()).called(1);
    });

    test('should return Error when remote data source fails', () async {
      final tException = Exception('Network error');
      when(mockDataSource.getAddresses()).thenAnswer(
        (_) async => Error<AddressesResponseDto>(exception: tException),
      );

      final result = await repository.getAddresses();

      expect(result, isA<Error<List<AddressEntity>>>());
      final errorResult = result as Error<List<AddressEntity>>;
      expect(errorResult.exception, tException);
      verify(mockDataSource.getAddresses()).called(1);
    });
  });

  group('addAddress', () {
    test('should return Success with entities when remote data source succeeds',
        () async {
      when(
        mockDataSource.addAddress(address: anyNamed('address')),
      ).thenAnswer(
        (_) async => Success<AddressesResponseDto>(data: tResponseDto),
      );

      final result = await repository.addAddress(address: tAddressEntity);

      expect(result, isA<Success<List<AddressEntity>>>());
      final successResult = result as Success<List<AddressEntity>>;
      expect(successResult.data, hasLength(1));
      verify(mockDataSource.addAddress(address: anyNamed('address'))).called(1);
    });

    test('should return Error when remote data source fails', () async {
      final tException = Exception('Add failed');
      when(
        mockDataSource.addAddress(address: anyNamed('address')),
      ).thenAnswer(
        (_) async => Error<AddressesResponseDto>(exception: tException),
      );

      final result = await repository.addAddress(address: tAddressEntity);

      expect(result, isA<Error<List<AddressEntity>>>());
      final errorResult = result as Error<List<AddressEntity>>;
      expect(errorResult.exception, tException);
      verify(mockDataSource.addAddress(address: anyNamed('address'))).called(1);
    });
  });

  group('updateAddress', () {
    test('should return Success with entities when remote data source succeeds',
        () async {
      when(
        mockDataSource.updateAddress(
          addressId: anyNamed('addressId'),
          address: anyNamed('address'),
        ),
      ).thenAnswer(
        (_) async => Success<AddressesResponseDto>(data: tResponseDto),
      );

      final result = await repository.updateAddress(address: tAddressEntity);

      expect(result, isA<Success<List<AddressEntity>>>());
      final successResult = result as Success<List<AddressEntity>>;
      expect(successResult.data, hasLength(1));
      verify(
        mockDataSource.updateAddress(
          addressId: anyNamed('addressId'),
          address: anyNamed('address'),
        ),
      ).called(1);
    });

    test('should return Error when remote data source fails', () async {
      final tException = Exception('Update failed');
      when(
        mockDataSource.updateAddress(
          addressId: anyNamed('addressId'),
          address: anyNamed('address'),
        ),
      ).thenAnswer(
        (_) async => Error<AddressesResponseDto>(exception: tException),
      );

      final result = await repository.updateAddress(address: tAddressEntity);

      expect(result, isA<Error<List<AddressEntity>>>());
      final errorResult = result as Error<List<AddressEntity>>;
      expect(errorResult.exception, tException);
      verify(
        mockDataSource.updateAddress(
          addressId: anyNamed('addressId'),
          address: anyNamed('address'),
        ),
      ).called(1);
    });

    test('should pass entity id as addressId', () async {
      when(
        mockDataSource.updateAddress(
          addressId: anyNamed('addressId'),
          address: anyNamed('address'),
        ),
      ).thenAnswer(
        (_) async => Success<AddressesResponseDto>(data: tResponseDto),
      );

      await repository.updateAddress(address: tAddressEntity);

      verify(
        mockDataSource.updateAddress(
          addressId: '1',
          address: anyNamed('address'),
        ),
      ).called(1);
    });
  });

  group('deleteAddress', () {
    test('should return Success with entities when remote data source succeeds',
        () async {
      when(mockDataSource.deleteAddress(addressId: anyNamed('addressId')))
          .thenAnswer(
        (_) async => Success<AddressesResponseDto>(data: tResponseDto),
      );

      final result = await repository.deleteAddress(addressId: '1');

      expect(result, isA<Success<List<AddressEntity>>>());
      final successResult = result as Success<List<AddressEntity>>;
      expect(successResult.data, hasLength(1));
      verify(mockDataSource.deleteAddress(addressId: '1')).called(1);
    });

    test('should return Error when remote data source fails', () async {
      final tException = Exception('Delete failed');
      when(mockDataSource.deleteAddress(addressId: anyNamed('addressId')))
          .thenAnswer(
        (_) async => Error<AddressesResponseDto>(exception: tException),
      );

      final result = await repository.deleteAddress(addressId: '1');

      expect(result, isA<Error<List<AddressEntity>>>());
      final errorResult = result as Error<List<AddressEntity>>;
      expect(errorResult.exception, tException);
      verify(mockDataSource.deleteAddress(addressId: '1')).called(1);
    });
  });
}
