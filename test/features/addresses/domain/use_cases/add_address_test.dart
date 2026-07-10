import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/features/addresses/domain/entities/address_entity.dart';
import 'package:flowers_app/features/addresses/domain/repositories/addresses_repository.dart';
import 'package:flowers_app/features/addresses/domain/use_cases/add_address.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'add_address_test.mocks.dart';

@GenerateMocks([AddressesRepository])
void main() {
  provideDummy<Result<List<AddressEntity>>>(
    const Success<List<AddressEntity>>(),
  );

  late AddAddressUseCase useCase;
  late MockAddressesRepository mockRepository;

  setUp(() {
    mockRepository = MockAddressesRepository();
    useCase = AddAddressUseCase(mockRepository);
  });

  const tEntity = AddressEntity(
    id: '1',
    street: '123 Main St',
    phone: '01010700700',
    city: 'Cairo',
    lat: '30.0444',
    long: '31.2357',
    username: 'ahmed',
  );

  final tAddresses = [tEntity];

  test('should add address via repository', () async {
    when(
      mockRepository.addAddress(address: anyNamed('address')),
    ).thenAnswer((_) async => Success(data: tAddresses));

    final result = await useCase(tEntity);

    expect(result, isA<Success<List<AddressEntity>>>());
    final successResult = result as Success<List<AddressEntity>>;
    expect(successResult.data, tAddresses);
    verify(mockRepository.addAddress(address: tEntity)).called(1);
  });

  test('should return error when repository fails', () async {
    final tException = Exception('Add failed');
    when(
      mockRepository.addAddress(address: anyNamed('address')),
    ).thenAnswer((_) async => Error(exception: tException));

    final result = await useCase(tEntity);

    expect(result, isA<Error<List<AddressEntity>>>());
    final errorResult = result as Error<List<AddressEntity>>;
    expect(errorResult.exception, tException);
    verify(mockRepository.addAddress(address: tEntity)).called(1);
  });
}
