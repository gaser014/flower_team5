import 'package:bloc_test/bloc_test.dart';
import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/config/base_state/base_state.dart';
import 'package:flowers_app/features/login/domain/use_cases/get_user_use_case.dart';
import 'package:flowers_app/features/logout/domain/use_cases/logout_use_case.dart';
import 'package:flowers_app/features/logout/presentation/view_model/cubit/logout_cubit.dart';
import 'package:flowers_app/features/logout/presentation/view_model/cubit/logout_events.dart';
import 'package:flowers_app/features/tracking_test/domain/use_cases/remove_user_token_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'logout_cubit_test.mocks.dart';

@GenerateMocks([LogoutUseCase, GetUserUseCase, RemoveUserTokenUseCase])
void main() {
  group('LogoutCubit Tests', () {
    late MockLogoutUseCase mockLogoutUseCase;
    late MockGetUserUseCase mockGetUserUseCase;
    late MockRemoveUserTokenUseCase mockRemoveUserTokenUseCase;

    setUp(() {
      mockLogoutUseCase = MockLogoutUseCase();
      mockGetUserUseCase = MockGetUserUseCase();
      mockRemoveUserTokenUseCase = MockRemoveUserTokenUseCase();
    });

    LogoutCubit buildCubit() => LogoutCubit(
      mockLogoutUseCase,
      mockGetUserUseCase,
      mockRemoveUserTokenUseCase,
    );

    test('initial state is BaseState.initial()', () {
      final cubit = buildCubit();
      expect(cubit.state.logoutState.isInitial, isTrue);
      cubit.close();
    });

    blocTest<LogoutCubit, LogoutStates>(
      'emits [loading, success] when DoLogoutEvent is added and usecase returns Success',
      setUp: () {
        when(
          mockGetUserUseCase.call(any),
        ).thenAnswer((_) async => const Success(data: null));
        when(
          mockLogoutUseCase.call(),
        ).thenAnswer((_) async => const Success(data: null));
      },
      build: () => buildCubit(),
      act: (cubit) => cubit.doIndented(const DoLogoutEvent()),
      expect: () => [
        const LogoutStates(logoutState: BaseState.loading()),
        const LogoutStates(logoutState: BaseState.success(null)),
      ],
    );

    final exception = Exception('Logout Failed');

    blocTest<LogoutCubit, LogoutStates>(
      'emits [loading, error] when DoLogoutEvent is added and usecase returns Error',
      setUp: () {
        when(
          mockGetUserUseCase.call(any),
        ).thenAnswer((_) async => const Success(data: null));
        when(
          mockLogoutUseCase.call(),
        ).thenAnswer((_) async => Error(exception: exception));
      },
      build: () => buildCubit(),
      act: (cubit) => cubit.doIndented(const DoLogoutEvent()),
      expect: () => [
        const LogoutStates(logoutState: BaseState.loading()),
        LogoutStates(logoutState: BaseState.error(exception)),
      ],
    );
  });
}
