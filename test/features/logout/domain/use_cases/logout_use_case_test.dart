import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/features/logout/domain/repositories/logout_repository.dart';
import 'package:flowers_app/features/logout/domain/use_cases/logout_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'logout_use_case_test.mocks.dart';

@GenerateMocks([LogoutRepository])
void main() {
  late LogoutUseCase logoutUseCase;
  late MockLogoutRepository mockLogoutRepository;

  setUp(() {
    mockLogoutRepository = MockLogoutRepository();
    logoutUseCase = LogoutUseCase(mockLogoutRepository);
  });

  test('should call logout on the repository and return Success', () async {
    // Arrange
    when(mockLogoutRepository.logout())
        .thenAnswer((_) async => const Success(data: null));

    // Act
    final result = await logoutUseCase.call();

    // Assert
    expect(result, isA<Success<void>>());
    verify(mockLogoutRepository.logout()).called(1);
    verifyNoMoreInteractions(mockLogoutRepository);
  });

  test('should call logout on the repository and return Error', () async {
    // Arrange
    final exception = Exception('test exception');
    when(mockLogoutRepository.logout())
        .thenAnswer((_) async => Error(exception: exception));

    // Act
    final result = await logoutUseCase.call();

    // Assert
    expect(result, isA<Error<void>>());
    result.when(
      success: (_) => fail('Should not be success'),
      error: (ex) => expect(ex, exception),
    );
    verify(mockLogoutRepository.logout()).called(1);
    verifyNoMoreInteractions(mockLogoutRepository);
  });
}
