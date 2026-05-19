import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/features/edit_profile/data/models/edit_profile_response_model.dart';

abstract interface class EditProfileRemoteDataSourceContract {
  Future<Result<EditProfileResponseModel>> editProfile({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String gender,
  });

  Future<Result<EditProfileResponseModel>> uploadPhoto({
    required String imagePath,
  });
}
