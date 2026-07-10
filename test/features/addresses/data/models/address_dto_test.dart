import 'package:flowers_app/features/addresses/data/models/address_dto.dart';
import 'package:flowers_app/features/addresses/domain/entities/address_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AddressDto', () {
    const tJson = {
      '_id': '1',
      'street': '123 Main St',
      'phone': '01010700700',
      'city': 'Cairo',
      'lat': '30.0444',
      'long': '31.2357',
      'username': 'ahmed',
    };

    const tEntity = AddressEntity(
      id: '1',
      street: '123 Main St',
      phone: '01010700700',
      city: 'Cairo',
      lat: '30.0444',
      long: '31.2357',
      username: 'ahmed',
    );

    const tDto = AddressDto(
      id: '1',
      street: '123 Main St',
      phone: '01010700700',
      city: 'Cairo',
      lat: '30.0444',
      long: '31.2357',
      username: 'ahmed',
    );

    test('fromJson should parse correctly', () {
      final result = AddressDto.fromJson(tJson);
      expect(result.id, '1');
      expect(result.street, '123 Main St');
      expect(result.phone, '01010700700');
      expect(result.city, 'Cairo');
      expect(result.lat, '30.0444');
      expect(result.long, '31.2357');
      expect(result.username, 'ahmed');
    });

    test('fromJson should handle null values', () {
      final result = AddressDto.fromJson({});
      expect(result.id, isNull);
      expect(result.street, isNull);
      expect(result.phone, isNull);
      expect(result.city, isNull);
      expect(result.lat, isNull);
      expect(result.long, isNull);
      expect(result.username, isNull);
    });

    test('toJson should exclude id', () {
      final result = tDto.toJson();
      expect(result, containsPair('street', '123 Main St'));
      expect(result, containsPair('phone', '01010700700'));
      expect(result, containsPair('city', 'Cairo'));
      expect(result, containsPair('lat', '30.0444'));
      expect(result, containsPair('long', '31.2357'));
      expect(result, containsPair('username', 'ahmed'));
      expect(result.containsKey('_id'), false);
      expect(result.containsKey('id'), false);
    });

    test('toJson with null fields should contain null values', () {
      final dto = const AddressDto();
      final result = dto.toJson();
      expect(result['street'], isNull);
      expect(result['phone'], isNull);
      expect(result['city'], isNull);
      expect(result['lat'], isNull);
      expect(result['long'], isNull);
      expect(result['username'], isNull);
    });

    test('fromEntity should create DTO from entity', () {
      final result = AddressDto.fromEntity(tEntity);
      expect(result.id, '1');
      expect(result.street, '123 Main St');
      expect(result.phone, '01010700700');
      expect(result.city, 'Cairo');
      expect(result.lat, '30.0444');
      expect(result.long, '31.2357');
      expect(result.username, 'ahmed');
    });

    test('fromEntity should handle entity with null fields', () {
      final entity = const AddressEntity();
      final result = AddressDto.fromEntity(entity);
      expect(result.id, isNull);
      expect(result.street, isNull);
      expect(result.phone, isNull);
      expect(result.city, isNull);
      expect(result.lat, isNull);
      expect(result.long, isNull);
      expect(result.username, isNull);
    });

    test('toEntity should create entity from DTO', () {
      final result = tDto.toEntity();
      expect(result.id, '1');
      expect(result.street, '123 Main St');
      expect(result.phone, '01010700700');
      expect(result.city, 'Cairo');
      expect(result.lat, '30.0444');
      expect(result.long, '31.2357');
      expect(result.username, 'ahmed');
    });

    test('toEntity should handle DTO with null fields', () {
      final dto = const AddressDto();
      final result = dto.toEntity();
      expect(result.id, isNull);
      expect(result.street, '');
      expect(result.phone, '');
      expect(result.city, '');
      expect(result.lat, isNull);
      expect(result.long, isNull);
      expect(result.username, isNull);
    });

    test('fromEntity and toEntity should be inverse', () {
      final dto = AddressDto.fromEntity(tEntity);
      final entity = dto.toEntity();
      expect(entity, tEntity);
    });
  });
}
