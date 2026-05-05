import 'package:flutter_test/flutter_test.dart';
import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/features/auth/sign_up/data/data_sources/sign_up_remote_data_source.dart';
import 'package:flowers_app/features/auth/sign_up/data/models/sign_up_request_model.dart';
import 'package:flowers_app/features/auth/sign_up/data/models/sign_up_response_model.dart';
import 'package:flowers_app/features/auth/sign_up/data/repos/sign_up_repo_impl.dart';
import 'package:flowers_app/features/auth/sign_up/domain/entities/sign_up_entity.dart';

class MockSignUpRemoteDataSource implements SignUpRemoteDataSource {
  SignUpResponseModel? mockResponse;
  Exception? mockException;
  bool signUpCalled = false;

  @override
  Future<SignUpResponseModel> signUp(SignUpRequestModel request) async {
    signUpCalled = true;
    if (mockException != null) {
      throw mockException!;
    }
    return mockResponse!;
  }
}

void main() {
  late SignUpRepoImpl signUpRepoImpl;
  late MockSignUpRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockSignUpRemoteDataSource();
    signUpRepoImpl = SignUpRepoImpl(mockRemoteDataSource);
  });

  const tSignUpResponseModel = SignUpResponseModel(
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
    mockRemoteDataSource.mockResponse = tSignUpResponseModel;

    // act
    final result = await signUpRepoImpl.signUp(
      firstName: 'John',
      lastName: 'Doe',
      email: 'test@example.com',
      password: 'password123',
      rePassword: 'password123',
      phone: '0123456789',
      gender: 'male',
    );

    // assert
    expect(result, isA<Success<SignUpEntity>>());
    expect(mockRemoteDataSource.signUpCalled, true);
  });

  test('should return Error when remote data source throws an exception', () async {
    // arrange
    mockRemoteDataSource.mockException = Exception('Server Error');

    // act
    final result = await signUpRepoImpl.signUp(
      firstName: 'John',
      lastName: 'Doe',
      email: 'test@example.com',
      password: 'password123',
      rePassword: 'password123',
      phone: '0123456789',
      gender: 'male',
    );

    // assert
    expect(result, isA<Error<SignUpEntity>>());
    expect(mockRemoteDataSource.signUpCalled, true);
  });
}
