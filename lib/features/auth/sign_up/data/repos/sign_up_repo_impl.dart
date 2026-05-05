import 'package:flowers_app/config/api/api_execute.dart';
import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/features/auth/sign_up/data/data_sources/sign_up_remote_data_source.dart';
import 'package:flowers_app/features/auth/sign_up/data/models/sign_up_request_model.dart';
import 'package:flowers_app/features/auth/sign_up/domain/entities/sign_up_entity.dart';
import 'package:flowers_app/features/auth/sign_up/domain/repos/sign_up_repo.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: SignUpRepo)
class SignUpRepoImpl implements SignUpRepo {
  final SignUpRemoteDataSource _remoteDataSource;

  SignUpRepoImpl(this._remoteDataSource);

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
        SignUpRequestModel(
          firstName: firstName,
          lastName: lastName,
          email: email,
          password: password,
          rePassword: rePassword,
          phone: phone,
          gender: gender,
        ),
      );

      return response.toEntity();
    });
  }
}
