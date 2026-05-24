import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/features/edit_profile/data/datasources/edit_profile_local_data_source_contract.dart';
import 'package:flowers_app/features/edit_profile/data/datasources/edit_profile_remote_data_source_contract.dart';
import 'package:flowers_app/features/edit_profile/domain/repositories/edit_profile_repository.dart';
import 'package:flowers_app/features/login/domain/entities/user_entity.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: EditProfileRepository)
class EditProfileRepositoryImpl implements EditProfileRepository {
  final EditProfileRemoteDataSourceContract _remoteDataSource;
  final EditProfileLocalDataSourceContract _localDataSource;

  const EditProfileRepositoryImpl(
    this._remoteDataSource,
    this._localDataSource,
  );

  @override
  Future<Result<UserEntity?>> editProfile({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String gender,
  }) async {
    final result = await _remoteDataSource.editProfile(
      firstName: firstName,
      lastName: lastName,
      email: email,
      phone: phone,
      gender: gender,
    );
    return result.when(
      success: (response) async {
        if (response?.user != null) {
          await _localDataSource.saveUser(response!.user!);
        }
        return Success<UserEntity?>(data: response?.user?.toUserEntity());
      },
      error: (exception) {
        return Error<UserEntity?>(exception: exception);
      },
    );
  }

  @override
  Future<Result<UserEntity?>> uploadPhoto({required String imagePath}) async {
    final result = await _remoteDataSource.uploadPhoto(imagePath: imagePath);
    return result.when(
      success: (response) async {
        if (response?.user != null) {
          await _localDataSource.saveUser(response!.user!);
        }
        return Success<UserEntity?>(data: response?.user?.toUserEntity());
      },
      error: (exception) {
        return Error<UserEntity?>(exception: exception);
      },
    );
  }

  @override
  Future<Result<UserEntity?>> getCachedUser() async {
    try {
      final user = await _localDataSource.getUser();
      return Success<UserEntity?>(data: user?.toUserEntity());
    } on Exception catch (e) {
      return Error<UserEntity?>(exception: e);
    }
  }
}
