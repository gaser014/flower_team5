import 'package:flowers_app/features/logout/api/api_client/logout_api_client.dart';
import 'package:flowers_app/features/logout/api/datasources/logout_remote_data_source_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'logout_remote_data_source_impl_test.mocks.dart';

@GenerateMocks([LogoutApiClient])
void main() {
  late LogoutRemoteDataSourceImpl dataSource;
  late MockLogoutApiClient mockApiClient;

  setUp(() {
    mockApiClient = MockLogoutApiClient();
    dataSource = LogoutRemoteDataSourceImpl(mockApiClient);
  });

  test('should call logout on the api client', () async {
    // Arrange
    when(mockApiClient.logout()).thenAnswer((_) async => Future.value());

    // Act
    await dataSource.logout();

    // Assert
    verify(mockApiClient.logout()).called(1);
    verifyNoMoreInteractions(mockApiClient);
  });

  test('should throw exception when api client throws', () async {
    // Arrange
    final exception = Exception('api error');
    when(mockApiClient.logout()).thenThrow(exception);

    // Act
    final call = dataSource.logout;

    // Assert
    expect(() => call(), throwsA(exception));
    verify(mockApiClient.logout()).called(1);
  });
}
