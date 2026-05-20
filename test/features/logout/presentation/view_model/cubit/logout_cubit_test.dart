import 'package:bloc_test/bloc_test.dart';
import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/config/base_state/base_state.dart';
import 'package:flowers_app/config/uses_cases/use_cases.dart';
import 'package:flowers_app/features/logout/domain/use_cases/logout_use_case.dart';
import 'package:flowers_app/features/logout/presentation/view_model/cubit/logout_cubit.dart';
import 'package:flowers_app/features/logout/presentation/view_model/cubit/logout_events.dart';
import 'package:flutter_test/flutter_test.dart';

// Manual mock for LogoutUseCase
class MockLogoutUseCase implements LogoutUseCase {
  final Result<void> result;
  MockLogoutUseCase({required this.result});

  @override
  Future<Result<void>> call(NoParams params) async {
    return result;
  }
}

void main() {
  group('LogoutCubit Tests', () {
    late LogoutCubit logoutCubit;
    late MockLogoutUseCase mockLogoutUseCase;

    setUp(() {
      // Default success mock
      mockLogoutUseCase = MockLogoutUseCase(result: const Success(data: null));
      logoutCubit = LogoutCubit(mockLogoutUseCase);
    });

    tearDown(() {
      logoutCubit.close();
    });

    test('initial state is BaseState.initial()', () {
      expect(logoutCubit.state.logoutState.isInitial, isTrue);
    });

    blocTest<LogoutCubit, LogoutStates>(
      'emits [loading, success] when DoLogoutEvent is added and usecase returns Success',
      build: () {
        mockLogoutUseCase = MockLogoutUseCase(result: const Success(data: null));
        return LogoutCubit(mockLogoutUseCase);
      },
      act: (cubit) => cubit.doIndented(const DoLogoutEvent()),
      expect: () => [
        const LogoutStates(logoutState: BaseState.loading()),
        const LogoutStates(logoutState: BaseState.success(null)),
      ],
    );

    final exception = Exception('Logout Failed');

    blocTest<LogoutCubit, LogoutStates>(
      'emits [loading, error] when DoLogoutEvent is added and usecase returns Error',
      build: () {
        mockLogoutUseCase = MockLogoutUseCase(result: Error(exception: exception));
        return LogoutCubit(mockLogoutUseCase);
      },
      act: (cubit) => cubit.doIndented(const DoLogoutEvent()),
      expect: () => [
        const LogoutStates(logoutState: BaseState.loading()),
        LogoutStates(logoutState: BaseState.error(exception)),
      ],
    );
  });
}
