import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flowers_app/config/base_state/base_state.dart';
import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/features/reset_password/data/models/reset_password_request.dart';
import 'package:flowers_app/features/reset_password/domain/use_cases/reset_password_use_case.dart';
import 'package:flowers_app/features/reset_password/presentation/view_model/cubit/reset_password_cubit.dart';
import 'package:flowers_app/features/reset_password/presentation/view_model/cubit/reset_password_events.dart';

class MockResetPasswordUseCase extends Mock implements ResetPasswordUseCase {}

class FakeResetPasswordRequest extends Fake implements ResetPasswordRequest {}

void main() {
  setUpAll(() {
    registerFallbackValue(FakeResetPasswordRequest());
  });

  late ResetPasswordCubit cubit;
  late MockResetPasswordUseCase mockUseCase;

  setUp(() {
    mockUseCase = MockResetPasswordUseCase();
    cubit = ResetPasswordCubit(mockUseCase);
  });

  tearDown(() {
    cubit.close();
  });

  final request = ResetPasswordRequest(
    currentPassword: 'oldPassword123',
    newPassword: 'newPassword123',
  );

  blocTest<ResetPasswordCubit, ResetPasswordStates>(
    'emits [Loading, Success] when reset password succeeds',
    build: () {
      when(() => mockUseCase.call(any()))
          .thenAnswer((_) async => const Success(data: true));
      return cubit;
    },
    act: (cubit) => cubit.doIndented(SubmitResetPasswordEvent(request)),
    expect: () => [
      const ResetPasswordStates(resetPasswordState: BaseState.loading()),
      const ResetPasswordStates(resetPasswordState: BaseState.success(true)),
    ],
  );

  blocTest<ResetPasswordCubit, ResetPasswordStates>(
    'emits [Loading, Error] when reset password fails',
    build: () {
      final exception = Exception('Invalid password');
      when(() => mockUseCase.call(any()))
          .thenAnswer((_) async => Error(exception: exception));
      return cubit;
    },
    act: (cubit) => cubit.doIndented(SubmitResetPasswordEvent(request)),
    expect: () => [
      const ResetPasswordStates(resetPasswordState: BaseState.loading()),
      ResetPasswordStates(resetPasswordState: BaseState.error(Exception('Invalid password'))),
    ],
  );
}
