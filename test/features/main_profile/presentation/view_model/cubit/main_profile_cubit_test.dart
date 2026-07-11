import 'package:bloc_test/bloc_test.dart';
import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/config/base_state/base_state.dart';
import 'package:flowers_app/features/login/domain/entities/user_entity.dart';
import 'package:flowers_app/features/login/domain/use_cases/get_user_use_case.dart';
import 'package:flowers_app/features/login/domain/use_cases/save_user_use_case.dart';
import 'package:flowers_app/features/main_profile/domain/use_cases/get_main_profile_use_case.dart';
import 'package:flowers_app/features/main_profile/presentation/view_model/cubit/main_profile_cubit.dart';
import 'package:flowers_app/features/main_profile/presentation/view_model/cubit/main_profile_events.dart';
import 'package:flowers_app/features/tracking_test/domain/use_cases/update_user_token_lang_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'main_profile_cubit_test.mocks.dart';

@GenerateMocks([
  GetMainProfileUseCase,
  SaveUserUseCase,
  GetUserUseCase,
  UpdateUserTokenLangUseCase,
])
void main() {
  late MainProfileCubit mainProfileCubit;
  late MockGetMainProfileUseCase mockGetMainProfileUseCase;
  late MockSaveUserUseCase mockSaveUserUseCase;
  late MockGetUserUseCase mockGetUserUseCase;
  late MockUpdateUserTokenLangUseCase mockUpdateUserTokenLangUseCase;

  provideDummy<Result<UserEntity>>(const Success(data: null));
  provideDummy<Result<void>>(const Success(data: null));

  setUp(() {
    mockGetMainProfileUseCase = MockGetMainProfileUseCase();
    mockSaveUserUseCase = MockSaveUserUseCase();
    mockGetUserUseCase = MockGetUserUseCase();
    mockUpdateUserTokenLangUseCase = MockUpdateUserTokenLangUseCase();
    mainProfileCubit = MainProfileCubit(
      mockGetMainProfileUseCase,
      mockSaveUserUseCase,
      mockGetUserUseCase,
      mockUpdateUserTokenLangUseCase,
    );
  });

  tearDown(() {
    mainProfileCubit.close();
  });

  group('MainProfileCubit - GetMainProfileEvent', () {
    final tUserEntity = UserEntity(
      firstName: 'John',
      lastName: 'Doe',
      email: 'john.doe@example.com',
      gender: 'male',
      phone: '1234567890',
      photo: 'photo_url',
    );

    blocTest<MainProfileCubit, MainProfileStates>(
      'emits [Loading, Success] when profile is fetched successfully and saved',
      build: () {
        when(
          mockGetMainProfileUseCase.call(any),
        ).thenAnswer((_) async => Success(data: tUserEntity));
        when(
          mockSaveUserUseCase.call(any),
        ).thenAnswer((_) async => const Success(data: null));
        return mainProfileCubit;
      },
      act: (cubit) => cubit.doIndented(GetMainProfileEvent()),
      expect: () => [
        const MainProfileStates(profileState: BaseState.loading()),
        MainProfileStates(profileState: BaseState.success(tUserEntity)),
      ],
      verify: (_) {
        verify(mockGetMainProfileUseCase.call(any)).called(1);
        verify(mockSaveUserUseCase.call(tUserEntity)).called(1);
      },
    );

    blocTest<MainProfileCubit, MainProfileStates>(
      'emits [Loading, Error] when fetching profile fails',
      build: () {
        final tException = Exception('Failed to fetch profile');
        when(
          mockGetMainProfileUseCase.call(any),
        ).thenAnswer((_) async => Error(exception: tException));
        return mainProfileCubit;
      },
      act: (cubit) => cubit.doIndented(GetMainProfileEvent()),
      expect: () => [
        const MainProfileStates(profileState: BaseState.loading()),
        isA<MainProfileStates>().having(
          (s) => s.profileState.isError,
          'isError',
          true,
        ),
      ],
      verify: (_) {
        verify(mockGetMainProfileUseCase.call(any)).called(1);
        verifyNever(mockSaveUserUseCase.call(any));
      },
    );
  });
}
