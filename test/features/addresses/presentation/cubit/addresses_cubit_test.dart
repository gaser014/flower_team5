import 'package:bloc_test/bloc_test.dart';
import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/config/base_state/base_state.dart';
import 'package:flowers_app/core/location_data/egypt_location_loader.dart';
import 'package:flowers_app/features/addresses/domain/entities/address_entity.dart';
import 'package:flowers_app/features/addresses/domain/use_cases/get_addresses.dart';
import 'package:flowers_app/features/addresses/domain/use_cases/add_address.dart';
import 'package:flowers_app/features/addresses/domain/use_cases/update_address.dart';
import 'package:flowers_app/features/addresses/domain/use_cases/delete_address.dart';
import 'package:flowers_app/features/addresses/presentation/cubit/addresses_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'addresses_cubit_test.mocks.dart';

@GenerateMocks([
  GetAddressesUseCase,
  AddAddressUseCase,
  UpdateAddressUseCase,
  DeleteAddressUseCase,
])
void main() {
  provideDummy<Result<List<AddressEntity>>>(
    const Success<List<AddressEntity>>(),
  );

  late MockGetAddressesUseCase mockGetAddressesUseCase;
  late MockAddAddressUseCase mockAddAddressUseCase;
  late MockUpdateAddressUseCase mockUpdateAddressUseCase;
  late MockDeleteAddressUseCase mockDeleteAddressUseCase;
  late AddressesCubit cubit;

  final tAddresses = [
    const AddressEntity(
      id: '1',
      street: '123 Main St',
      phone: '01010700700',
      city: 'Cairo',
      lat: '30.0444',
      long: '31.2357',
      username: 'ahmed',
    ),
  ];

  const tEntity = AddressEntity(
    id: '1',
    street: '123 Main St',
    phone: '01010700700',
    city: 'Cairo',
    lat: '30.0444',
    long: '31.2357',
    username: 'ahmed',
  );

  setUp(() {
    mockGetAddressesUseCase = MockGetAddressesUseCase();
    mockAddAddressUseCase = MockAddAddressUseCase();
    mockUpdateAddressUseCase = MockUpdateAddressUseCase();
    mockDeleteAddressUseCase = MockDeleteAddressUseCase();
    cubit = AddressesCubit(
      getAddressesUseCase: mockGetAddressesUseCase,
      addAddressUseCase: mockAddAddressUseCase,
      updateAddressUseCase: mockUpdateAddressUseCase,
      deleteAddressUseCase: mockDeleteAddressUseCase,
    );
  });

  tearDown(() {
    cubit.close();
  });

  group('initial state', () {
    test('should have initial state', () {
      expect(cubit.state.getAddressesState.isInitial, true);
      expect(cubit.state.addAddressState.isInitial, true);
      expect(cubit.state.updateAddressState.isInitial, true);
      expect(cubit.state.deleteAddressState.isInitial, true);
      expect(cubit.state.formSelectedCity, isNull);
      expect(cubit.state.formSelectedArea, isNull);
      expect(cubit.state.formSelectedLat, 31.04516268641246);
      expect(cubit.state.formSelectedLng, 31.376411453247112);
    });
  });

  group('GetAddressesEvent', () {
    blocTest<AddressesCubit, AddressesStates>(
      'emits [loading, success] when getAddresses succeeds',
      build: () {
        when(mockGetAddressesUseCase.call(any)).thenAnswer(
          (_) async => Success(data: tAddresses),
        );
        return cubit;
      },
      act: (cubit) => cubit.doIntent(const GetAddressesEvent()),
      expect: () => [
        isA<AddressesStates>().having(
          (s) => s.getAddressesState.isLoading,
          'getAddressesState.loading',
          true,
        ),
        isA<AddressesStates>().having(
          (s) => s.getAddressesState.isSuccess,
          'getAddressesState.success',
          true,
        ),
      ],
      verify: (_) {
        verify(mockGetAddressesUseCase.call(any)).called(1);
      },
    );

    blocTest<AddressesCubit, AddressesStates>(
      'emits [loading, error] when getAddresses returns null data',
      build: () {
        when(mockGetAddressesUseCase.call(any)).thenAnswer(
          (_) async => const Success<List<AddressEntity>>(data: null),
        );
        return cubit;
      },
      act: (cubit) => cubit.doIntent(const GetAddressesEvent()),
      expect: () => [
        isA<AddressesStates>().having(
          (s) => s.getAddressesState.isLoading,
          'getAddressesState.loading',
          true,
        ),
        isA<AddressesStates>().having(
          (s) => s.getAddressesState.isError,
          'getAddressesState.error',
          true,
        ),
      ],
    );

    blocTest<AddressesCubit, AddressesStates>(
      'emits [loading, error] when getAddresses fails',
      build: () {
        when(mockGetAddressesUseCase.call(any)).thenAnswer(
          (_) async => Error(exception: Exception('Network error')),
        );
        return cubit;
      },
      act: (cubit) => cubit.doIntent(const GetAddressesEvent()),
      expect: () => [
        isA<AddressesStates>().having(
          (s) => s.getAddressesState.isLoading,
          'getAddressesState.loading',
          true,
        ),
        isA<AddressesStates>().having(
          (s) => s.getAddressesState.isError,
          'getAddressesState.error',
          true,
        ),
      ],
    );

    blocTest<AddressesCubit, AddressesStates>(
      'should not emit loading when already loading',
      build: () {
        when(mockGetAddressesUseCase.call(any)).thenAnswer(
          (_) async => Success(data: tAddresses),
        );
        return cubit;
      },
      act: (cubit) async {
        cubit.doIntent(const GetAddressesEvent());
        cubit.doIntent(const GetAddressesEvent());
        await Future.delayed(const Duration(milliseconds: 50));
      },
      verify: (_) {
        verify(mockGetAddressesUseCase.call(any)).called(1);
      },
    );
  });

  group('AddAddressEvent', () {
    blocTest<AddressesCubit, AddressesStates>(
      'emits [loading, success] when addAddress succeeds',
      build: () {
        when(mockAddAddressUseCase.call(any)).thenAnswer(
          (_) async => Success(data: tAddresses),
        );
        return cubit;
      },
      act: (cubit) => cubit.doIntent(AddAddressEvent(entity: tEntity)),
      expect: () => [
        isA<AddressesStates>().having(
          (s) => s.addAddressState.isLoading,
          'addAddressState.loading',
          true,
        ),
        isA<AddressesStates>().having(
          (s) => s.addAddressState.isSuccess,
          'addAddressState.success',
          true,
        ),
      ],
      verify: (_) {
        verify(mockAddAddressUseCase.call(tEntity)).called(1);
      },
    );

    blocTest<AddressesCubit, AddressesStates>(
      'emits [loading, error] when addAddress returns null data',
      build: () {
        when(mockAddAddressUseCase.call(any)).thenAnswer(
          (_) async => const Success<List<AddressEntity>>(data: null),
        );
        return cubit;
      },
      act: (cubit) => cubit.doIntent(AddAddressEvent(entity: tEntity)),
      expect: () => [
        isA<AddressesStates>().having(
          (s) => s.addAddressState.isLoading,
          'addAddressState.loading',
          true,
        ),
        isA<AddressesStates>().having(
          (s) => s.addAddressState.isError,
          'addAddressState.error',
          true,
        ),
      ],
    );

    blocTest<AddressesCubit, AddressesStates>(
      'emits [loading, error] when addAddress fails',
      build: () {
        when(mockAddAddressUseCase.call(any)).thenAnswer(
          (_) async => Error(exception: Exception('Add failed')),
        );
        return cubit;
      },
      act: (cubit) => cubit.doIntent(AddAddressEvent(entity: tEntity)),
      expect: () => [
        isA<AddressesStates>().having(
          (s) => s.addAddressState.isLoading,
          'addAddressState.loading',
          true,
        ),
        isA<AddressesStates>().having(
          (s) => s.addAddressState.isError,
          'addAddressState.error',
          true,
        ),
      ],
    );

    blocTest<AddressesCubit, AddressesStates>(
      'should update getAddressesState on success',
      build: () {
        when(mockAddAddressUseCase.call(any)).thenAnswer(
          (_) async => Success(data: tAddresses),
        );
        return cubit;
      },
      act: (cubit) => cubit.doIntent(AddAddressEvent(entity: tEntity)),
      expect: () => [
        isA<AddressesStates>().having(
          (s) => s.addAddressState.isLoading,
          'addAddressState.loading',
          true,
        ),
        isA<AddressesStates>().having(
          (s) => s.addAddressState.isSuccess,
          'addAddressState.success',
          true,
        ).having(
          (s) => s.getAddressesState.isSuccess,
          'getAddressesState.success',
          true,
        ),
      ],
    );
  });

  group('UpdateAddressEvent', () {
    blocTest<AddressesCubit, AddressesStates>(
      'emits [loading, success] when updateAddress succeeds',
      build: () {
        when(mockUpdateAddressUseCase.call(any)).thenAnswer(
          (_) async => Success(data: tAddresses),
        );
        return cubit;
      },
      act: (cubit) => cubit.doIntent(UpdateAddressEvent(entity: tEntity)),
      expect: () => [
        isA<AddressesStates>().having(
          (s) => s.updateAddressState.isLoading,
          'updateAddressState.loading',
          true,
        ),
        isA<AddressesStates>().having(
          (s) => s.updateAddressState.isSuccess,
          'updateAddressState.success',
          true,
        ),
      ],
      verify: (_) {
        verify(mockUpdateAddressUseCase.call(tEntity)).called(1);
      },
    );

    blocTest<AddressesCubit, AddressesStates>(
      'emits [loading, error] when updateAddress returns null data',
      build: () {
        when(mockUpdateAddressUseCase.call(any)).thenAnswer(
          (_) async => const Success<List<AddressEntity>>(data: null),
        );
        return cubit;
      },
      act: (cubit) => cubit.doIntent(UpdateAddressEvent(entity: tEntity)),
      expect: () => [
        isA<AddressesStates>().having(
          (s) => s.updateAddressState.isLoading,
          'updateAddressState.loading',
          true,
        ),
        isA<AddressesStates>().having(
          (s) => s.updateAddressState.isError,
          'updateAddressState.error',
          true,
        ),
      ],
    );

    blocTest<AddressesCubit, AddressesStates>(
      'emits [loading, error] when updateAddress fails',
      build: () {
        when(mockUpdateAddressUseCase.call(any)).thenAnswer(
          (_) async => Error(exception: Exception('Update failed')),
        );
        return cubit;
      },
      act: (cubit) => cubit.doIntent(UpdateAddressEvent(entity: tEntity)),
      expect: () => [
        isA<AddressesStates>().having(
          (s) => s.updateAddressState.isLoading,
          'updateAddressState.loading',
          true,
        ),
        isA<AddressesStates>().having(
          (s) => s.updateAddressState.isError,
          'updateAddressState.error',
          true,
        ),
      ],
    );
  });

  group('DeleteAddressEvent', () {
    blocTest<AddressesCubit, AddressesStates>(
      'emits [loading, success] when deleteAddress succeeds',
      build: () {
        when(mockDeleteAddressUseCase.call(any)).thenAnswer(
          (_) async => Success(data: tAddresses),
        );
        return cubit;
      },
      act: (cubit) => cubit.doIntent(const DeleteAddressEvent(id: '1')),
      expect: () => [
        isA<AddressesStates>().having(
          (s) => s.deleteAddressState.isLoading,
          'deleteAddressState.loading',
          true,
        ),
        isA<AddressesStates>().having(
          (s) => s.deleteAddressState.isSuccess,
          'deleteAddressState.success',
          true,
        ),
      ],
      verify: (_) {
        verify(mockDeleteAddressUseCase.call('1')).called(1);
      },
    );

    blocTest<AddressesCubit, AddressesStates>(
      'emits [loading, error] when deleteAddress returns null data',
      build: () {
        when(mockDeleteAddressUseCase.call(any)).thenAnswer(
          (_) async => const Success<List<AddressEntity>>(data: null),
        );
        return cubit;
      },
      act: (cubit) => cubit.doIntent(const DeleteAddressEvent(id: '1')),
      expect: () => [
        isA<AddressesStates>().having(
          (s) => s.deleteAddressState.isLoading,
          'deleteAddressState.loading',
          true,
        ),
        isA<AddressesStates>().having(
          (s) => s.deleteAddressState.isError,
          'deleteAddressState.error',
          true,
        ),
      ],
    );

    blocTest<AddressesCubit, AddressesStates>(
      'emits [loading, error] when deleteAddress fails',
      build: () {
        when(mockDeleteAddressUseCase.call(any)).thenAnswer(
          (_) async => Error(exception: Exception('Delete failed')),
        );
        return cubit;
      },
      act: (cubit) => cubit.doIntent(const DeleteAddressEvent(id: '1')),
      expect: () => [
        isA<AddressesStates>().having(
          (s) => s.deleteAddressState.isLoading,
          'deleteAddressState.loading',
          true,
        ),
        isA<AddressesStates>().having(
          (s) => s.deleteAddressState.isError,
          'deleteAddressState.error',
          true,
        ),
      ],
    );
  });

  group('UpdateFormCityEvent', () {
    const tCity = CityItem(id: '1', nameEn: 'Cairo', nameAr: 'القاهرة');

    blocTest<AddressesCubit, AddressesStates>(
      'should update formSelectedCity and clear formSelectedArea',
      build: () => cubit,
      act: (cubit) => cubit.doIntent(const UpdateFormCityEvent(city: tCity)),
      expect: () => [
        isA<AddressesStates>().having(
          (s) => s.formSelectedCity,
          'formSelectedCity',
          tCity,
        ).having(
          (s) => s.formSelectedArea,
          'formSelectedArea is null after city change',
          isNull,
        ),
      ],
    );
  });

  group('UpdateFormAreaEvent', () {
    const tCity = CityItem(id: '1', nameEn: 'Cairo', nameAr: 'القاهرة');
    const tArea = AreaItem(
      id: '1',
      cityId: '1',
      nameEn: 'Downtown',
      nameAr: 'وسط البلد',
    );

    blocTest<AddressesCubit, AddressesStates>(
      'should update formSelectedArea',
      build: () => cubit,
      act: (cubit) async {
        cubit.doIntent(const UpdateFormCityEvent(city: tCity));
        cubit.doIntent(const UpdateFormAreaEvent(area: tArea));
      },
      expect: () => [
        isA<AddressesStates>().having(
          (s) => s.formSelectedCity,
          'formSelectedCity',
          tCity,
        ),
        isA<AddressesStates>().having(
          (s) => s.formSelectedArea,
          'formSelectedArea',
          tArea,
        ),
      ],
    );

    blocTest<AddressesCubit, AddressesStates>(
      'should handle null area',
      build: () => cubit,
      act: (cubit) => cubit.doIntent(const UpdateFormAreaEvent(area: null)),
      expect: () => [
        isA<AddressesStates>().having(
          (s) => s.formSelectedArea,
          'formSelectedArea is null',
          isNull,
        ),
      ],
    );
  });

  group('ResetFormEvent', () {
    blocTest<AddressesCubit, AddressesStates>(
      'should reset all form fields to defaults',
      build: () {
        // First set some values, then reset
        return cubit;
      },
      act: (cubit) async {
        cubit.doIntent(const UpdateFormCityEvent(
          city: CityItem(id: '1', nameEn: 'Cairo', nameAr: 'القاهرة'),
        ));
        cubit.doIntent(const ResetFormEvent());
      },
      expect: () => [
        isA<AddressesStates>().having(
          (s) => s.formSelectedCity,
          'formSelectedCity set',
          isNotNull,
        ),
        isA<AddressesStates>().having(
          (s) => s.formSelectedCity,
          'formSelectedCity cleared',
          isNull,
        ).having(
          (s) => s.formSelectedArea,
          'formSelectedArea cleared',
          isNull,
        ).having(
          (s) => s.formSelectedLat,
          'formSelectedLat reset',
          31.04516268641246,
        ).having(
          (s) => s.formSelectedLng,
          'formSelectedLng reset',
          31.376411453247112,
        ),
      ],
    );
  });

  group('UpdateFormLocationEvent', () {
    const tCity = CityItem(id: '1', nameEn: 'Cairo', nameAr: 'القاهرة');
    const tArea = AreaItem(
      id: '1',
      cityId: '1',
      nameEn: 'Downtown',
      nameAr: 'وسط البلد',
    );

    blocTest<AddressesCubit, AddressesStates>(
      'should update lat, lng, and city (area cleared when city is set)',
      build: () => cubit,
      act: (cubit) => cubit.doIntent(
        const UpdateFormLocationEvent(
          lat: 30.0,
          lng: 31.0,
          city: tCity,
        ),
      ),
      expect: () => [
        isA<AddressesStates>().having(
          (s) => s.formSelectedLat,
          'lat updated',
          30.0,
        ).having(
          (s) => s.formSelectedLng,
          'lng updated',
          31.0,
        ).having(
          (s) => s.formSelectedCity,
          'city updated',
          tCity,
        ).having(
          (s) => s.formSelectedArea,
          'area cleared when city is set',
          isNull,
        ),
      ],
    );

    blocTest<AddressesCubit, AddressesStates>(
      'should update lat, lng, and area without city',
      build: () => cubit,
      act: (cubit) => cubit.doIntent(
        const UpdateFormLocationEvent(
          lat: 30.0,
          lng: 31.0,
          area: tArea,
        ),
      ),
      expect: () => [
        isA<AddressesStates>().having(
          (s) => s.formSelectedLat,
          'lat updated',
          30.0,
        ).having(
          (s) => s.formSelectedLng,
          'lng updated',
          31.0,
        ).having(
          (s) => s.formSelectedArea,
          'area updated',
          tArea,
        ),
      ],
    );

    blocTest<AddressesCubit, AddressesStates>(
      'should clear area when city is provided',
      build: () => cubit,
      act: (cubit) => cubit.doIntent(
        const UpdateFormLocationEvent(city: tCity),
      ),
      expect: () => [
        isA<AddressesStates>().having(
          (s) => s.formSelectedCity,
          'city updated',
          tCity,
        ).having(
          (s) => s.formSelectedArea,
          'area cleared when city set',
          isNull,
        ),
      ],
    );

    blocTest<AddressesCubit, AddressesStates>(
      'should update only lat and lng',
      build: () => cubit,
      act: (cubit) => cubit.doIntent(
        const UpdateFormLocationEvent(lat: 30.5, lng: 31.5),
      ),
      expect: () => [
        isA<AddressesStates>().having(
          (s) => s.formSelectedLat,
          'lat updated',
          30.5,
        ).having(
          (s) => s.formSelectedLng,
          'lng updated',
          31.5,
        ),
      ],
    );
  });

  group('reset', () {
    blocTest<AddressesCubit, AddressesStates>(
      'should reset to initial state',
      build: () => cubit,
      act: (cubit) => cubit.reset(),
      expect: () => [
        const AddressesStates(),
      ],
    );
  });

  group('doIntent with error with null exception', () {
    blocTest<AddressesCubit, AddressesStates>(
      'handles null exception in getAddresses error',
      build: () {
        when(mockGetAddressesUseCase.call(any)).thenAnswer(
          (_) async => const Error<List<AddressEntity>>(),
        );
        return cubit;
      },
      act: (cubit) => cubit.doIntent(const GetAddressesEvent()),
      expect: () => [
        isA<AddressesStates>().having(
          (s) => s.getAddressesState.isLoading,
          'loading',
          true,
        ),
        isA<AddressesStates>().having(
          (s) => s.getAddressesState.isError,
          'error',
          true,
        ),
      ],
    );
  });
}
