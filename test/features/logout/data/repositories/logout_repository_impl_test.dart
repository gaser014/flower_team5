import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/config/error_handling/failures.dart';
import 'package:flowers_app/core/data/data_sources/auth_local_data_source.dart';
import 'package:flowers_app/features/logout/data/datasources/logout_remote_data_source_contract.dart';
import 'package:flowers_app/features/logout/data/repositories/logout_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:get_it/get_it.dart';

import 'logout_repository_impl_test.mocks.dart';

@GenerateMocks([LogoutRemoteDataSourceContract, AuthLocalDataSourceContract, InternetConnection])
void main() {
  late LogoutRepositoryImpl repository;
  late MockLogoutRemoteDataSourceContract mockRemoteDataSource;
  late MockAuthLocalDataSourceContract mockLocalDataSource;
  late MockInternetConnection mockInternetConnection;

  setUp(() {
    mockRemoteDataSource = MockLogoutRemoteDataSourceContract();
    mockLocalDataSource = MockAuthLocalDataSourceContract();
    mockInternetConnection = MockInternetConnection();

    // Setup DI for executeApi which relies on InternetConnection
    final getIt = GetIt.instance;
    getIt.reset();
    getIt.registerSingleton<InternetConnection>(mockInternetConnection);

    when(mockInternetConnection.hasInternetAccess).thenAnswer((_) async => true);

    repository = LogoutRepositoryImpl(mockRemoteDataSource, mockLocalDataSource);
  });

  test('should return Success and clear session when remote logout is successful', () async {
    // Arrange
    when(mockRemoteDataSource.logout()).thenAnswer((_) async => Future.value());
    when(mockLocalDataSource.clearSession()).thenAnswer((_) async => Future.value());

    // Act
    final result = await repository.logout();

    // Assert
    expect(result, isA<Success<void>>());
    verify(mockRemoteDataSource.logout()).called(1);
    verify(mockLocalDataSource.clearSession()).called(1);
  });

  test('should return Error and clear session when remote logout throws exception', () async {
    // Arrange
    final exception = Exception('test exception');
    when(mockRemoteDataSource.logout()).thenThrow(exception);
    when(mockLocalDataSource.clearSession()).thenAnswer((_) async => Future.value());

    // Act
    final result = await repository.logout();

    // Assert
    expect(result, isA<Error<void>>());
    result.when(
      success: (_) => fail('Should not be success'),
      error: (ex) => expect(ex, exception),
    );
    verify(mockRemoteDataSource.logout()).called(1);
    verify(mockLocalDataSource.clearSession()).called(1);
  });

  test('should return NetworkFailures when no internet', () async {
    // Arrange
    when(mockInternetConnection.hasInternetAccess).thenAnswer((_) async => false);
    when(mockLocalDataSource.clearSession()).thenAnswer((_) async => Future.value());

    // Act
    final result = await repository.logout();

    // Assert
    expect(result, isA<Error<void>>());
    result.when(
      success: (_) => fail('Should not be success'),
      error: (ex) => expect(ex, isA<NetworkFailures>()),
    );
    // Remote should not be called
    verifyNever(mockRemoteDataSource.logout());
    verify(mockLocalDataSource.clearSession()).called(1);
  });
}
