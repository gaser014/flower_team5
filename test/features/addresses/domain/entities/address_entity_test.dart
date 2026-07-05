import 'package:flowers_app/features/addresses/domain/entities/address_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AddressEntity', () {
    const tEntity = AddressEntity(
      id: '1',
      street: '123 Main St',
      phone: '01010700700',
      city: 'Cairo',
      lat: '30.0444',
      long: '31.2357',
      username: 'ahmed',
    );

    test('should have correct props', () {
      expect(
        tEntity.props,
        ['1', '123 Main St', '01010700700', 'Cairo', '30.0444', '31.2357', 'ahmed'],
      );
    });

    test('should support value equality', () {
      const copy = AddressEntity(
        id: '1',
        street: '123 Main St',
        phone: '01010700700',
        city: 'Cairo',
        lat: '30.0444',
        long: '31.2357',
        username: 'ahmed',
      );
      expect(tEntity, copy);
    });

    test('should not be equal when fields differ', () {
      const different = AddressEntity(id: '2');
      expect(tEntity, isNot(different));
    });

    test('empty entity should have all null fields', () {
      const empty = AddressEntity();
      expect(empty.id, isNull);
      expect(empty.street, isNull);
      expect(empty.phone, isNull);
      expect(empty.city, isNull);
      expect(empty.lat, isNull);
      expect(empty.long, isNull);
      expect(empty.username, isNull);
    });

    group('copyWith', () {
      test('should return same instance when no args', () {
        final copy = tEntity.copyWith();
        expect(copy, tEntity);
      });

      test('should override id', () {
        final copy = tEntity.copyWith(id: '2');
        expect(copy.id, '2');
        expect(copy.street, '123 Main St');
      });

      test('should override street', () {
        final copy = tEntity.copyWith(street: '456 Oak Ave');
        expect(copy.street, '456 Oak Ave');
        expect(copy.id, '1');
      });

      test('should override phone', () {
        final copy = tEntity.copyWith(phone: '01111111111');
        expect(copy.phone, '01111111111');
      });

      test('should override city', () {
        final copy = tEntity.copyWith(city: 'Alexandria');
        expect(copy.city, 'Alexandria');
      });

      test('should override lat', () {
        final copy = tEntity.copyWith(lat: '31.2000');
        expect(copy.lat, '31.2000');
      });

      test('should override long', () {
        final copy = tEntity.copyWith(long: '29.9000');
        expect(copy.long, '29.9000');
      });

      test('should override username', () {
        final copy = tEntity.copyWith(username: 'mohamed');
        expect(copy.username, 'mohamed');
      });

      test('should override multiple fields', () {
        final copy = tEntity.copyWith(
          id: '2',
          street: 'New St',
          city: 'Giza',
        );
        expect(copy.id, '2');
        expect(copy.street, 'New St');
        expect(copy.city, 'Giza');
        expect(copy.phone, '01010700700');
      });
    });
  });
}
