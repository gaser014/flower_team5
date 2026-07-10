import 'package:flowers_app/features/addresses/domain/entities/addresses_params.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AddressParams', () {
    const tParams = AddressParams(id: '1');

    test('should have correct props', () {
      expect(tParams.props, ['1']);
    });

    test('should support value equality', () {
      const copy = AddressParams(id: '1');
      expect(tParams, copy);
    });

    test('should not be equal when id differs', () {
      const different = AddressParams(id: '2');
      expect(tParams, isNot(different));
    });
  });
}
