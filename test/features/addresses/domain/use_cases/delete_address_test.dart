import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/features/addresses/domain/entities/address_entity.dart';
import 'package:flowers_app/features/addresses/domain/repositories/addresses_repository.dart';
import 'package:flowers_app/features/addresses/domain/use_cases/delete_address.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'delete_address_test.mocks.dart';

@GenerateMocks([AddressesRepository])
void main() {
  provideDummy<Result<List<AddressEntity>>>(
    const Success<List<AddressEntity>>(),
  );

  late DeleteAddressUseCase useCase;
  late MockAddressesRepository mockRepository;

  setUp(() {
    mockRepository = MockAddressesRepository();
    useCase = DeleteAddressUseCase(mockRepository);
  });

  const tAddressId = '1';

  test('should delete address via repository', () async {
    when(
      mockRepository.deleteAddress(addressId: anyNamed('addressId')),
    ).thenAnswer((_) async => const Success<List<AddressEntity>>(data: []));

    final result = await useCase(tAddressId);

    expect(result, isA<Success<List<AddressEntity>>>());
    verify(mockRepository.deleteAddress(addressId: tAddressId)).called(1);
  });

  test('should return error when repository fails', () async {
    final tException = Exception('Delete failed');
    when(
      mockRepository.deleteAddress(addressId: anyNamed('addressId')),
    ).thenAnswer((_) async => Error(exception: tException));

    final result = await useCase(tAddressId);

    expect(result, isA<Error<List<AddressEntity>>>());
    final errorResult = result as Error<List<AddressEntity>>;
    expect(errorResult.exception, tException);
    verify(mockRepository.deleteAddress(addressId: tAddressId)).called(1);
  });
}
