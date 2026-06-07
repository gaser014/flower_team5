import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/features/login/data/models/user_model.dart';
import 'package:flowers_app/features/login/domain/entities/user_entity.dart';
import 'package:flowers_app/features/main_profile/data/datasources/main_profile_remote_data_source_contract.dart';
import 'package:flowers_app/features/main_profile/data/models/profile_data_response_model.dart';
import 'package:flowers_app/features/main_profile/data/repositories/main_profile_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'main_profile_repository_impl_test.mocks.dart';

@GenerateMocks([MainProfileRemoteDataSourceContract])
void main() {
  late MainProfileRepositoryImpl repository;
  late MockMainProfileRemoteDataSourceContract mockRemoteDataSource;

  provideDummy<Result<ProfileDataResponseModel>>(const Success(data: null));

  setUp(() {
    mockRemoteDataSource = MockMainProfileRemoteDataSourceContract();
    repository = MainProfileRepositoryImpl(mockRemoteDataSource);
  });

  group('MainProfileRepositoryImpl', () {
    final tUserModel = UserModel(
      firstName: 'John',
      lastName: 'Doe',
      email: 'john.doe@example.com',
    );
    final tProfileDataResponseModel = ProfileDataResponseModel(
      message: 'Success',
      user: tUserModel,
    );
    final tUserEntity = tUserModel.toUserEntity();

    test(
      'should return Success with UserEntity when remote source call is successful and user is not null',
      () async {
        // arrange
        when(
          mockRemoteDataSource.getProfileData(),
        ).thenAnswer((_) async => Success(data: tProfileDataResponseModel));

        // act
        final result = await repository.getProfileData();

        // assert
        verify(mockRemoteDataSource.getProfileData()).called(1);
        expect(result, isA<Success<UserEntity>>());
        final successResult = result as Success<UserEntity>;
        expect(successResult.data?.email, tUserEntity.email);
      },
    );

    test(
      'should return Error when remote source call is successful but user is null',
      () async {
        // arrange
        final tProfileDataResponseModelNullUser = ProfileDataResponseModel(
          message: 'Success',
          user: null,
        );
        when(mockRemoteDataSource.getProfileData()).thenAnswer(
          (_) async => Success(data: tProfileDataResponseModelNullUser),
        );

        // act
        final result = await repository.getProfileData();

        // assert
        verify(mockRemoteDataSource.getProfileData()).called(1);
        expect(result, isA<Error<UserEntity>>());
        final errorResult = result as Error<UserEntity>;
        expect(
          errorResult.exception.toString(),
          Exception("User data is null").toString(),
        );
      },
    );

    test('should return Error when remote source call fails', () async {
      // arrange
      final tException = Exception('Failed');
      when(
        mockRemoteDataSource.getProfileData(),
      ).thenAnswer((_) async => Error(exception: tException));

      // act
      final result = await repository.getProfileData();

      // assert
      verify(mockRemoteDataSource.getProfileData()).called(1);
      expect(result, isA<Error<UserEntity>>());
      final errorResult = result as Error<UserEntity>;
      expect(errorResult.exception, tException);
    });
  });
}
