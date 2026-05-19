import 'package:dio/dio.dart';
import 'package:flowers_app/config/api/end_points.dart';
import 'package:flowers_app/features/edit_profile/data/models/edit_profile_response_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'edit_profile_api_client.g.dart';

@Injectable()
@RestApi(baseUrl: EndPoints.baseUrl)
abstract class EditProfileApiClient {
  @factoryMethod
  factory EditProfileApiClient(Dio dio) = _EditProfileApiClient;

  @PUT(EndPoints.editUserProfile)
  Future<EditProfileResponseModel> editProfile(
    @Body() Map<String, dynamic> body,
  );

  @PATCH(EndPoints.updateProfilePhoto)
  @MultiPart()
  Future<EditProfileResponseModel> uploadPhoto(
    @Part(name: "photo") MultipartFile photo,
  );
}
