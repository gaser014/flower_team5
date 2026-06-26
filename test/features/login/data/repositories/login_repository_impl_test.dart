import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/config/uses_cases/login_params.dart';
import 'package:flowers_app/features/login/api/datasources/login_local_data_source_impl.dart';
import 'package:flowers_app/features/login/api/datasources/login_remote_data_source_impl.dart';
import 'package:flowers_app/features/login/data/models/login_response_model.dart';
import 'package:flowers_app/features/login/data/models/user_model.dart';
import 'package:flowers_app/features/login/data/repositories/login_repository_impl.dart';
import 'package:flowers_app/features/login/domain/entities/login_response_entity.dart';
import 'package:flowers_app/features/login/domain/entities/user_entity.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'login_repository_impl_test.mocks.dart';

@GenerateMocks([LoginLocalDataSourceImpl, LoginRemoteDataSourceImpl])
void main() {
  provideDummy<Result<LoginResponseModel>>(const Success<LoginResponseModel>());
  provideDummy<Result<UserModel>>(const Success<UserModel>());
  late LoginRepositoryImpl loginRepositoryImpl;
  late MockLoginRemoteDataSourceImpl mockRemoteDataSource;
  late MockLoginLocalDataSourceImpl mockLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockLoginRemoteDataSourceImpl();
    mockLocalDataSource = MockLoginLocalDataSourceImpl();

    loginRepositoryImpl = LoginRepositoryImpl(
      mockRemoteDataSource,
      mockLocalDataSource,
    );
  });

  group('Login Remote', () {
    const tLoginParams = LoginParams(
      email: 'test@test.com',
      password: 'password',
      lang: "en",
    );

    final tLoginResponseModel = LoginResponseModel(
      message: 'success',
      token: 'token123',
      user: UserModel(id: '1', email: 'test@test.com'),
    );

    test('should return Success when login succeeds', () async {
      // Arrange
      when(mockRemoteDataSource.login(any)).thenAnswer(
        (_) async => Success<LoginResponseModel>(data: tLoginResponseModel),
      );

      // Act
      final result = await loginRepositoryImpl.login(tLoginParams);

      // Assert
      expect(result, isA<Success<LoginResponseEntity>>());

      verify(mockRemoteDataSource.login(any)).called(1);
    });

    test('should return Error when login fails', () async {
      // Arrange
      final tException = Exception('error');

      when(mockRemoteDataSource.login(any)).thenAnswer(
        (_) async => Error<LoginResponseModel>(exception: tException),
      );

      // Act
      final result = await loginRepositoryImpl.login(tLoginParams);

      // Assert
      expect(result, isA<Error<LoginResponseEntity>>());

      final errorResult = result as Error<LoginResponseEntity>;

      expect(errorResult.exception, tException);

      verify(mockRemoteDataSource.login(any)).called(1);
    });
  });

  group('Local Storage Save User', () {
    final tUserEntity = UserEntity(
      id: '1',
      email: 'test@test.com',
      role: 'user',
      phone: '123456789',
      firstName: 'testFirstName',
      lastName: 'testLastName',
      gender: 'male',
      photo: 'https://example.com/photo.jpg',
    );

    final tUserModel = UserModel.fromUserEntity(tUserEntity);

    test('should return Success when saveUser succeeds', () async {
      // Arrange
      when(
        mockLocalDataSource.saveUser(any),
      ).thenAnswer((_) async => tUserModel);

      // Act
      final result = await loginRepositoryImpl.saveUser(tUserEntity);

      // Assert
      expect(result, isA<Success<UserEntity>>());

      verify(mockLocalDataSource.saveUser(any)).called(1);
    });

    test('should return Error when saveUser fails', () async {
      // Arrange
      when(
        mockLocalDataSource.saveUser(any),
      ).thenThrow(Exception('local error'));

      // Act
      final result = await loginRepositoryImpl.saveUser(tUserEntity);

      // Assert
      expect(result, isA<Error<UserEntity>>());

      verify(mockLocalDataSource.saveUser(any)).called(1);
    });
  });

  group('Local Storage Get User', () {
    final tUserModel = UserModel(
      id: '1',
      email: 'test@test.com',
      role: 'user',
      phone: '123456789',
      firstName: 'testFirstName',
      lastName: 'testLastName',
    );

    test('should return Success when getUser succeeds', () async {
      // Arrange
      when(mockLocalDataSource.getUser()).thenAnswer((_) async => tUserModel);

      // Act
      final result = await loginRepositoryImpl.getUser();

      // Assert
      expect(result, isA<Success<UserEntity?>>());

      final successResult = result as Success<UserEntity?>;

      expect(successResult.data?.id, tUserModel.id);

      verify(mockLocalDataSource.getUser()).called(1);
    });

    test('should return Error when getUser throws exception', () async {
      // Arrange
      when(
        mockLocalDataSource.getUser(),
      ).thenThrow(Exception('get user error'));

      // Act
      final result = await loginRepositoryImpl.getUser();

      // Assert
      expect(result, isA<Error<UserEntity?>>());

      verify(mockLocalDataSource.getUser()).called(1);
    });

    test('should return Error when getUser returns null', () async {
      // Arrange
      when(mockLocalDataSource.getUser()).thenAnswer((_) async => null);

      // Act
      final result = await loginRepositoryImpl.getUser();

      // Assert
      expect(result, isA<Success<UserEntity?>>());

      final successResult = result as Success<UserEntity?>;

      expect(successResult.data, null);
    });
  });
}
