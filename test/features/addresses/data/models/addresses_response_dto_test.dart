import 'package:flowers_app/features/addresses/data/models/address_dto.dart';
import 'package:flowers_app/features/addresses/data/models/addresses_response_dto.dart';
import 'package:flowers_app/features/addresses/domain/entities/address_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AddressesResponseDto', () {
    final tAddressJson = {
      '_id': '1',
      'street': '123 Main St',
      'phone': '01010700700',
      'city': 'Cairo',
      'lat': '30.0444',
      'long': '31.2357',
      'username': 'ahmed',
    };

    final tDto = AddressDto(
      id: '1',
      street: '123 Main St',
      phone: '01010700700',
      city: 'Cairo',
      lat: '30.0444',
      long: '31.2357',
      username: 'ahmed',
    );

    test('fromJson should parse with "address" key', () {
      final json = {
        'message': 'success',
        'address': [tAddressJson],
      };
      final result = AddressesResponseDto.fromJson(json);
      expect(result.message, 'success');
      expect(result.addresses, hasLength(1));
      expect(result.addresses!.first.id, '1');
    });

    test('fromJson should parse with "addresses" key', () {
      final json = {
        'message': 'success',
        'addresses': [tAddressJson],
      };
      final result = AddressesResponseDto.fromJson(json);
      expect(result.message, 'success');
      expect(result.addresses, hasLength(1));
      expect(result.addresses!.first.id, '1');
    });

    test('fromJson should handle "address" key when both present', () {
      final json = {
        'message': 'success',
        'address': [tAddressJson],
        'addresses': [tAddressJson, tAddressJson],
      };
      final result = AddressesResponseDto.fromJson(json);
      expect(result.addresses, hasLength(1));
    });

    test('fromJson should handle null addresses', () {
      final json = {'message': 'success'};
      final result = AddressesResponseDto.fromJson(json);
      expect(result.message, 'success');
      expect(result.addresses, isNull);
    });

    test('fromJson should handle empty list', () {
      final json = {'message': 'success', 'addresses': []};
      final result = AddressesResponseDto.fromJson(json);
      expect(result.addresses, isEmpty);
    });

    test('toJson should serialize correctly', () {
      final response = AddressesResponseDto(
        message: 'success',
        addresses: [tDto],
      );
      final result = response.toJson();
      expect(result['message'], 'success');
      expect(result['addresses'], isA<List>());
      expect((result['addresses'] as List).first, isA<Map<String, dynamic>>());
    });

    test('toJson with null fields', () {
      final response = const AddressesResponseDto();
      final result = response.toJson();
      expect(result['message'], isNull);
      expect(result['addresses'], isNull);
    });

    test('toEntities should convert to list of AddressEntity', () {
      final response = AddressesResponseDto(
        message: 'success',
        addresses: [tDto],
      );
      final entities = response.toEntities();
      expect(entities, hasLength(1));
      expect(entities.first, isA<AddressEntity>());
      expect(entities.first.id, '1');
      expect(entities.first.street, '123 Main St');
    });

    test('toEntities should return empty list when addresses is null', () {
      final response = const AddressesResponseDto();
      final entities = response.toEntities();
      expect(entities, isEmpty);
    });

    test('toEntities should return empty list when addresses is empty', () {
      final response = const AddressesResponseDto(addresses: []);
      final entities = response.toEntities();
      expect(entities, isEmpty);
    });
  });
}
