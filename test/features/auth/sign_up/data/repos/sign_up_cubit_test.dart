import 'package:flowers_app/config/helper/enum/gender.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/features/auth/sign_up/domain/entities/sign_up_entity.dart';
import 'package:flowers_app/features/auth/sign_up/domain/use_cases/sign_up_use_case.dart';
import 'package:flowers_app/features/auth/sign_up/presentation/cubit/sign_up_cubit.dart';
import 'package:flowers_app/features/auth/sign_up/presentation/cubit/sign_up_state.dart';

class MockSignUpUseCase implements SignUpUseCase {
  Result<SignUpEntity>? mockResult;
  bool callCalled = false;

  @override
  Future<Result<SignUpEntity>> call(SignUpParams params) async {
    callCalled = true;
    return mockResult!;
  }
}

void main() {
  late SignUpCubit signUpCubit;
  late MockSignUpUseCase mockSignUpUseCase;

  setUp(() {
    mockSignUpUseCase = MockSignUpUseCase();
    signUpCubit = SignUpCubit(mockSignUpUseCase);
  });

  tearDown(() {
    signUpCubit.close();
  });

  test('initial state should be correct', () {
    expect(signUpCubit.state, const SignUpState());
  });

  group('Cubit Basic Functions', () {
    test('changeGender should update the state', () {
      signUpCubit.changeGender(Gender.male);
      expect(signUpCubit.state.gender, Gender.male);
    });

    test('togglePasswordVisibility should update the state', () {
      final initialVisibility = signUpCubit.state.isPasswordVisible;
      signUpCubit.togglePasswordVisibility();
      expect(signUpCubit.state.isPasswordVisible, !initialVisibility);
    });

    test('toggleConfirmPasswordVisibility should update the state', () {
      final initialVisibility = signUpCubit.state.isConfirmPasswordVisible;
      signUpCubit.toggleConfirmPasswordVisibility();
      expect(signUpCubit.state.isConfirmPasswordVisible, !initialVisibility);
    });
  });
}
