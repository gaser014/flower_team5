import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/config/uses_cases/use_cases.dart';
import 'package:flowers_app/features/addresses/domain/entities/address_entity.dart';
import 'package:flowers_app/features/addresses/domain/repositories/addresses_repository.dart';
import 'package:flowers_app/features/addresses/domain/use_cases/get_addresses.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_addresses_test.mocks.dart';

@GenerateMocks([AddressesRepository])
void main() {
  provideDummy<Result<List<AddressEntity>>>(
    const Success<List<AddressEntity>>(),
  );

  late GetAddressesUseCase useCase;
  late MockAddressesRepository mockRepository;

  setUp(() {
    mockRepository = MockAddressesRepository();
    useCase = GetAddressesUseCase(mockRepository);
  });

  const tAddresses = [AddressEntity(id: '1', street: 'Test St')];

  test('should return addresses from repository', () async {
    when(mockRepository.getAddresses()).thenAnswer(
      (_) async => Success(data: tAddresses),
    );

    final result = await useCase(const NoParams());

    expect(result, isA<Success<List<AddressEntity>>>());
    final successResult = result as Success<List<AddressEntity>>;
    expect(successResult.data, tAddresses);
    verify(mockRepository.getAddresses()).called(1);
  });

  test('should return error when repository fails', () async {
    final tException = Exception('Failed');
    when(mockRepository.getAddresses()).thenAnswer(
      (_) async => Error(exception: tException),
    );

    final result = await useCase(const NoParams());

    expect(result, isA<Error<List<AddressEntity>>>());
    final errorResult = result as Error<List<AddressEntity>>;
    expect(errorResult.exception, tException);
    verify(mockRepository.getAddresses()).called(1);
  });
}
