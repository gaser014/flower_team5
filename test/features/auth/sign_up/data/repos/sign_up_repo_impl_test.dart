import 'package:flowers_app/core/data/data_sources/auth_local_data_source.dart';
import 'package:flowers_app/features/auth/sign_up/domain/entities/user_entity.dart';

import 'package:flutter_test/flutter_test.dart';
import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/features/auth/sign_up/data/data_sources/sign_up_remote_data_source.dart';
import 'package:flowers_app/features/auth/sign_up/data/models/sign_up_request_dto.dart';
import 'package:flowers_app/features/auth/sign_up/data/models/sign_up_response_dto.dart';
import 'package:flowers_app/features/auth/sign_up/data/repositories/sign_up_repository_impl.dart';
import 'package:flowers_app/features/auth/sign_up/domain/entities/sign_up_entity.dart';

class MockSignUpRemoteDataSource implements SignUpRemoteDataSource {
  SignUpResponseDto? mockResponse;
  Exception? mockException;
  bool signUpCalled = false;

  @override
  Future<SignUpResponseDto> signUp(SignUpRequestDto request) async {
    signUpCalled = true;
    if (mockException != null) {
      throw mockException!;
    }
    return mockResponse!;
  }
}

class MockAuthLocalDataSource implements AuthLocalDataSourceContract {
  @override
  Future<void> saveUserToken(String token) async {}
  @override
  Future<String?> getUserToken() async => null;
  @override
  Future<void> deleteUserToken() async {}

  @override
  Future<void> clearSession() async {}
}

void main() {
  late SignUpRepositoryImpl signUpRepositoryImpl;
  late MockSignUpRemoteDataSource mockRemoteDataSource;
  late MockAuthLocalDataSource mockAuthLocalDataSource;

  setUp(() {
    mockRemoteDataSource = MockSignUpRemoteDataSource();
    mockAuthLocalDataSource = MockAuthLocalDataSource();
    signUpRepositoryImpl = SignUpRepositoryImpl(
      mockRemoteDataSource,
      mockAuthLocalDataSource,
    );
  });

  const tSignUpResponseDto = SignUpResponseDto(
    message: 'Success',
    token: 'token123',
    user: {
      'firstName': 'John',
      'lastName': 'Doe',
      'email': 'test@example.com',
      'phone': '0123456789',
      'gender': 'male',
    },
  );

  test('should call signUp on remote data source and return Success', () async {
    // arrange
    mockRemoteDataSource.mockResponse = tSignUpResponseDto;

    // act
    final result = await signUpRepositoryImpl.signUp(
      userEntity: UserEntity(
        firstName: 'John',
        lastName: 'Doe',
        email: 'test@example.com',
        password: 'password123',
        rePassword: 'password123',
        phone: '0123456789',
        gender: 'male',
      ),
    );

    // assert
    expect(result, isA<Success<SignUpEntity>>());
    expect(mockRemoteDataSource.signUpCalled, true);
  });

  test(
    'should return Error when remote data source throws an exception',
    () async {
      // arrange
      mockRemoteDataSource.mockException = Exception('Server Error');

      // act
      final result = await signUpRepositoryImpl.signUp(
        userEntity: UserEntity(
          firstName: 'John',
          lastName: 'Doe',
          email: 'test@example.com',
          password: 'password123',
          rePassword: 'password123',
          phone: '0123456789',
          gender: 'male',
        ),
      );

      // assert
      expect(result, isA<Error<SignUpEntity>>());
      expect(mockRemoteDataSource.signUpCalled, true);
    },
  );
}
