import 'package:bloc_test/bloc_test.dart';
import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/config/base_state/base_state.dart';
import 'package:flowers_app/features/logout/domain/use_cases/logout_use_case.dart';
import 'package:flowers_app/features/logout/presentation/view_model/cubit/logout_cubit.dart';
import 'package:flowers_app/features/logout/presentation/view_model/cubit/logout_events.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'logout_cubit_test.mocks.dart';

@GenerateMocks([LogoutUseCase])
void main() {
  group('LogoutCubit Tests', () {
    late MockLogoutUseCase mockLogoutUseCase;

    setUp(() {
      mockLogoutUseCase = MockLogoutUseCase();
    });

    test('initial state is BaseState.initial()', () {
      final cubit = LogoutCubit(mockLogoutUseCase);
      expect(cubit.state.logoutState.isInitial, isTrue);
      cubit.close();
    });

    blocTest<LogoutCubit, LogoutStates>(
      'emits [loading, success] when DoLogoutEvent is added and usecase returns Success',
      setUp: () {
        when(mockLogoutUseCase.call())
            .thenAnswer((_) async => const Success(data: null));
      },
      build: () => LogoutCubit(mockLogoutUseCase),
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
        when(mockLogoutUseCase.call())
            .thenAnswer((_) async => Error(exception: exception));
      },
      build: () => LogoutCubit(mockLogoutUseCase),
      act: (cubit) => cubit.doIndented(const DoLogoutEvent()),
      expect: () => [
        const LogoutStates(logoutState: BaseState.loading()),
        LogoutStates(logoutState: BaseState.error(exception)),
      ],
    );
  });
}
