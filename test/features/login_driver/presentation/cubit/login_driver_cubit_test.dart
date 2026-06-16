import 'package:bloc_test/bloc_test.dart';
import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/config/base_state/base_state.dart';
import 'package:flowers_app/config/uses_cases/login_params.dart';
import 'package:flowers_app/config/uses_cases/use_cases.dart';
import 'package:flowers_app/features/login_Driver/domain/entities/driver_login_response_entity.dart';
import 'package:flowers_app/features/login_Driver/domain/use_cases/delete_driver_credentials_use_case.dart';
import 'package:flowers_app/features/login_Driver/domain/use_cases/delete_driver_token_use_case.dart';
import 'package:flowers_app/features/login_Driver/domain/use_cases/get_driver_credentials_use_case.dart';
import 'package:flowers_app/features/login_Driver/domain/use_cases/login_driver_use_case.dart';
import 'package:flowers_app/features/login_Driver/domain/use_cases/save_driver_credentials_use_case.dart';
import 'package:flowers_app/features/login_Driver/domain/use_cases/save_driver_token_use_case.dart';
import 'package:flowers_app/features/login_Driver/presentation/view_model/cubit/login_Driver_cubit.dart';
import 'package:flowers_app/features/login_Driver/presentation/view_model/cubit/login_Driver_events.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_driver_cubit_test.mocks.dart';

@GenerateMocks([
  LoginDriverUseCase,
  SaveDriverTokenUseCase,
  DeleteDriverTokenUseCase,
  SaveDriverCredentialsUseCase,
  GetDriverCredentialsUseCase,
  DeleteDriverCredentialsUseCase,
])
void main() {
  late LoginDriverCubit cubit;
  late MockLoginDriverUseCase mockLoginUseCase;
  late MockSaveDriverTokenUseCase mockSaveTokenUseCase;
  late MockDeleteDriverTokenUseCase mockDeleteTokenUseCase;
  late MockSaveDriverCredentialsUseCase mockSaveCredentialsUseCase;
  late MockGetDriverCredentialsUseCase mockGetCredentialsUseCase;
  late MockDeleteDriverCredentialsUseCase mockDeleteCredentialsUseCase;

  // ── Helpers ──────────────────────────────────────────────────────────────

  const tEmail = 'driver@test.com';
  const tPassword = 'Pass@123';
  const tToken = 'fake_token_xyz';

  final tLoginParams = LoginParams(
    email: tEmail,
    password: tPassword,
    remember: false,
  );

  final tLoginParamsRemember = LoginParams(
    email: tEmail,
    password: tPassword,
    remember: true,
  );

  final tResponse = DriverLoginResponseEntity(
    message: 'Success',
    token: tToken,
  );

  final tCredentials = {
    'driverSavedEmail': tEmail,
    'driverSavedPassword': tPassword,
  };

  setUp(() {
    mockLoginUseCase = MockLoginDriverUseCase();
    mockSaveTokenUseCase = MockSaveDriverTokenUseCase();
    mockDeleteTokenUseCase = MockDeleteDriverTokenUseCase();
    mockSaveCredentialsUseCase = MockSaveDriverCredentialsUseCase();
    mockGetCredentialsUseCase = MockGetDriverCredentialsUseCase();
    mockDeleteCredentialsUseCase = MockDeleteDriverCredentialsUseCase();

    cubit = LoginDriverCubit(
      mockLoginUseCase,
      mockSaveTokenUseCase,
      mockDeleteTokenUseCase,
      mockSaveCredentialsUseCase,
      mockGetCredentialsUseCase,
      mockDeleteCredentialsUseCase,
    );

    // Default stubs to avoid MissingStubError
    when(
      mockSaveTokenUseCase.call(any),
    ).thenAnswer((_) async => const Success(data: null));
    when(
      mockDeleteTokenUseCase.call(any),
    ).thenAnswer((_) async => const Success(data: null));
    when(
      mockSaveCredentialsUseCase.call(
        email: anyNamed('email'),
        password: anyNamed('password'),
      ),
    ).thenAnswer((_) async => const Success(data: null));
    when(
      mockDeleteCredentialsUseCase.call(any),
    ).thenAnswer((_) async => const Success(data: null));
    when(
      mockGetCredentialsUseCase.call(any),
    ).thenAnswer((_) async => const Success(data: null));
  });

  tearDown(() => cubit.close());

  // ── Initial state ─────────────────────────────────────────────────────────

  group('initial state', () {
    test('should be LoginDriverStates with all initial values', () {
      expect(cubit.state, const LoginDriverStates());
      expect(cubit.state.loginState.isInitial, true);
      expect(cubit.state.rememberMeState.data, false);
      expect(cubit.state.showPasswordState.data, false);
    });
  });

  // ── Login — success ───────────────────────────────────────────────────────

  group('login success', () {
    blocTest<LoginDriverCubit, LoginDriverStates>(
      'emits [loading, success] on successful login without remember me',
      build: () {
        when(
          mockLoginUseCase.call(tLoginParams),
        ).thenAnswer((_) async => Success(data: tResponse));
        return cubit;
      },
      act: (c) => c.doIndented(LoginDriverEvent(params: tLoginParams)),
      expect: () => [
        isA<LoginDriverStates>().having(
          (s) => s.loginState.isLoading,
          'isLoading',
          true,
        ),
        isA<LoginDriverStates>()
            .having((s) => s.loginState.isSuccess, 'isSuccess', true)
            .having(
              (s) => (s.loginState.data as DriverLoginResponseEntity?)?.token,
              'token',
              tToken,
            ),
      ],
    );

    blocTest<LoginDriverCubit, LoginDriverStates>(
      'saves credentials when remember me is true',
      build: () {
        when(
          mockLoginUseCase.call(tLoginParamsRemember),
        ).thenAnswer((_) async => Success(data: tResponse));
        return cubit;
      },
      act: (c) => c.doIndented(LoginDriverEvent(params: tLoginParamsRemember)),
      verify: (_) {
        verify(
          mockSaveCredentialsUseCase.call(email: tEmail, password: tPassword),
        ).called(1);
        verifyNever(mockDeleteCredentialsUseCase.call(any));
      },
    );

    blocTest<LoginDriverCubit, LoginDriverStates>(
      'deletes credentials when remember me is false',
      build: () {
        when(
          mockLoginUseCase.call(tLoginParams),
        ).thenAnswer((_) async => Success(data: tResponse));
        return cubit;
      },
      act: (c) => c.doIndented(LoginDriverEvent(params: tLoginParams)),
      verify: (_) {
        verify(mockDeleteCredentialsUseCase.call(any)).called(1);
        verifyNever(
          mockSaveCredentialsUseCase.call(
            email: anyNamed('email'),
            password: anyNamed('password'),
          ),
        );
      },
    );

    blocTest<LoginDriverCubit, LoginDriverStates>(
      'saves token on successful login',
      build: () {
        when(
          mockLoginUseCase.call(tLoginParams),
        ).thenAnswer((_) async => Success(data: tResponse));
        return cubit;
      },
      act: (c) => c.doIndented(LoginDriverEvent(params: tLoginParams)),
      verify: (_) {
        verify(mockSaveTokenUseCase.call(tToken)).called(1);
      },
    );
  });

  // ── Login — error ─────────────────────────────────────────────────────────

  group('login error', () {
    blocTest<LoginDriverCubit, LoginDriverStates>(
      'emits [loading, error] on failed login',
      build: () {
        when(mockLoginUseCase.call(tLoginParams)).thenAnswer(
          (_) async => Error(exception: Exception('Invalid credentials')),
        );
        return cubit;
      },
      act: (c) => c.doIndented(LoginDriverEvent(params: tLoginParams)),
      expect: () => [
        isA<LoginDriverStates>().having(
          (s) => s.loginState.isLoading,
          'isLoading',
          true,
        ),
        isA<LoginDriverStates>().having(
          (s) => s.loginState.isError,
          'isError',
          true,
        ),
      ],
    );

    blocTest<LoginDriverCubit, LoginDriverStates>(
      'does NOT save token on failed login',
      build: () {
        when(
          mockLoginUseCase.call(tLoginParams),
        ).thenAnswer((_) async => Error(exception: Exception('error')));
        return cubit;
      },
      act: (c) => c.doIndented(LoginDriverEvent(params: tLoginParams)),
      verify: (_) {
        verifyNever(mockSaveTokenUseCase.call(any));
      },
    );
  });

  // ── Remember Me ───────────────────────────────────────────────────────────

  group('rememberMe', () {
    blocTest<LoginDriverCubit, LoginDriverStates>(
      'emits rememberMe = true when toggled on',
      build: () => cubit,
      act: (c) => c.doIndented(RememberMeDriverEvent(rememberMe: true)),
      expect: () => [
        isA<LoginDriverStates>().having(
          (s) => s.rememberMeState.data,
          'rememberMe',
          true,
        ),
      ],
    );

    blocTest<LoginDriverCubit, LoginDriverStates>(
      'emits rememberMe = false when toggled off',
      build: () => cubit,
      act: (c) => c.doIndented(RememberMeDriverEvent(rememberMe: false)),
      expect: () => [
        isA<LoginDriverStates>().having(
          (s) => s.rememberMeState.data,
          'rememberMe',
          false,
        ),
      ],
    );
  });

  // ── Show Password ─────────────────────────────────────────────────────────

  group('showPassword', () {
    blocTest<LoginDriverCubit, LoginDriverStates>(
      'emits showPassword = true when toggled on',
      build: () => cubit,
      act: (c) => c.doIndented(ShowPasswordDriverEvent(showPassword: true)),
      expect: () => [
        isA<LoginDriverStates>().having(
          (s) => s.showPasswordState.data,
          'showPassword',
          true,
        ),
      ],
    );

    blocTest<LoginDriverCubit, LoginDriverStates>(
      'emits showPassword = false when toggled off',
      build: () => cubit,
      act: (c) => c.doIndented(ShowPasswordDriverEvent(showPassword: false)),
      expect: () => [
        isA<LoginDriverStates>().having(
          (s) => s.showPasswordState.data,
          'showPassword',
          false,
        ),
      ],
    );
  });

  // ── Logout ────────────────────────────────────────────────────────────────

  group('logout', () {
    blocTest<LoginDriverCubit, LoginDriverStates>(
      'emits [loading, success] on successful logout',
      build: () => cubit,
      act: (c) => c.doIndented(LogoutDriverEvent()),
      expect: () => [
        isA<LoginDriverStates>().having(
          (s) => s.logoutState.isLoading,
          'isLoading',
          true,
        ),
        isA<LoginDriverStates>().having(
          (s) => s.logoutState.isSuccess,
          'isSuccess',
          true,
        ),
      ],
    );

    blocTest<LoginDriverCubit, LoginDriverStates>(
      'emits [loading, error] on failed logout',
      build: () {
        when(
          mockDeleteTokenUseCase.call(any),
        ).thenAnswer((_) async => Error(exception: Exception('logout failed')));
        return cubit;
      },
      act: (c) => c.doIndented(LogoutDriverEvent()),
      expect: () => [
        isA<LoginDriverStates>().having(
          (s) => s.logoutState.isLoading,
          'isLoading',
          true,
        ),
        isA<LoginDriverStates>().having(
          (s) => s.logoutState.isError,
          'isError',
          true,
        ),
      ],
    );
  });

  // ── Load Saved Credentials ────────────────────────────────────────────────

  group('loadSavedCredentials', () {
    blocTest<LoginDriverCubit, LoginDriverStates>(
      'emits savedCredentials and rememberMe = true when credentials exist',
      build: () {
        when(
          mockGetCredentialsUseCase.call(any),
        ).thenAnswer((_) async => Success(data: tCredentials));
        return cubit;
      },
      act: (c) => c.loadSavedCredentials(),
      expect: () => [
        isA<LoginDriverStates>()
            .having(
              (s) => s.savedCredentials.data?['driverSavedEmail'],
              'savedEmail',
              tEmail,
            )
            .having((s) => s.rememberMeState.data, 'rememberMe', true),
      ],
    );

    blocTest<LoginDriverCubit, LoginDriverStates>(
      'emits nothing when no credentials are saved',
      build: () {
        when(
          mockGetCredentialsUseCase.call(any),
        ).thenAnswer((_) async => const Success(data: null));
        return cubit;
      },
      act: (c) => c.loadSavedCredentials(),
      expect: () => [],
    );
  });
}
