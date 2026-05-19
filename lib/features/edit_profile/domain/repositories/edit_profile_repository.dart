import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/features/login/domain/entities/user_entity.dart';

abstract interface class EditProfileRepository {
  Future<Result<UserEntity?>> editProfile({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String gender,
  });

  Future<Result<UserEntity?>> uploadPhoto({required String imagePath});

  Future<Result<UserEntity?>> getCachedUser();
}
