import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/features/main_profile/data/models/profile_data_response_model.dart';

abstract class MainProfileRemoteDataSourceContract {
  Future<Result<ProfileDataResponseModel>> getProfileData();
}
