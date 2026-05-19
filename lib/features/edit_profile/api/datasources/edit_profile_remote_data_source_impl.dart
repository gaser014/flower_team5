import 'package:dio/dio.dart';
import 'package:flowers_app/config/api/api_execute.dart';
import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/features/edit_profile/api/api_client/edit_profile_api_client.dart';
import 'package:flowers_app/features/edit_profile/data/datasources/edit_profile_remote_data_source_contract.dart';
import 'package:flowers_app/features/edit_profile/data/models/edit_profile_response_model.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: EditProfileRemoteDataSourceContract)
class EditProfileRemoteDataSourceImpl implements EditProfileRemoteDataSourceContract {
  final EditProfileApiClient _apiClient;

  const EditProfileRemoteDataSourceImpl(this._apiClient);

  @override
  Future<Result<EditProfileResponseModel>> editProfile({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String gender,
  }) async {
    return await executeApi(() async {
      final response = await _apiClient.editProfile({
        "firstName": firstName,
        "lastName": lastName,
        "email": email,
        "phone": phone,
        "gender": gender,
      });
      return response;
    });
  }

  @override
  Future<Result<EditProfileResponseModel>> uploadPhoto({
    required String imagePath,
  }) async {
    return await executeApi(() async {
      final multipartFile = await MultipartFile.fromFile(
        imagePath,
        filename: imagePath.split('/').last,
      );
      final response = await _apiClient.uploadPhoto(multipartFile);
      return response;
    });
  }
}
