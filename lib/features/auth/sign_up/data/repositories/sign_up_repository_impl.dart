import 'package:flowers_app/config/api/api_execute.dart';
import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/core/data/data_sources/auth_local_data_source.dart';
import 'package:flowers_app/features/auth/sign_up/data/data_sources/sign_up_remote_data_source.dart';
import 'package:flowers_app/features/auth/sign_up/data/models/sign_up_request_dto.dart';
import 'package:flowers_app/features/auth/sign_up/domain/entities/sign_up_entity.dart';
import 'package:flowers_app/features/auth/sign_up/domain/repositories/sign_up_repository_contract.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: SignUpRepositoryContract)
class SignUpRepositoryImpl implements SignUpRepositoryContract {
  final SignUpRemoteDataSource _remoteDataSource;
  final AuthLocalDataSourceContract _localDataSource;

  SignUpRepositoryImpl(this._remoteDataSource, this._localDataSource);

  @override
  Future<Result<SignUpEntity>> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String rePassword,
    required String phone,
    required String gender,
  }) async {
    return await executeApi<SignUpEntity>(() async {
      final response = await _remoteDataSource.signUp(
        SignUpRequestDto(
          firstName: firstName,
          lastName: lastName,
          email: email,
          password: password,
          rePassword: rePassword,
          phone: phone,
          gender: gender,
        ),
      );

      final entity = response.toEntity();
      
      // Save token locally if sign up is successful
      if (entity.token != null) {
        await _localDataSource.saveUserToken(entity.token!);
      }

      return entity;
    });
  }
}
