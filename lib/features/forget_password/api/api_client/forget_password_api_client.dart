import 'package:dio/dio.dart';
import 'package:flowers_app/config/api/end_points.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import '../../data/models/forget_password_request_models.dart';
import '../../data/models/forget_password_response_models.dart';
import 'package:flowers_app/features/forget_password/domain/entities/forget_password_params.dart';

part 'forget_password_api_client.g.dart';

@LazySingleton()
@RestApi()
abstract class ForgetPasswordApiClient {
  @factoryMethod
  factory ForgetPasswordApiClient(Dio dio) = _ForgetPasswordApiClient;

  @POST(EndPoints.forgetPasswordEndpoint)
  Future<ForgetPasswordResponse> sendForgetPasswordCode(
      @Body() ForgetPasswordRequest request);

  @POST(EndPoints.verifyResetEndpoint)
  Future<ForgetPasswordResponse> verifyForgetPasswordCode(
      @Body() VerifyCodeRequest request);

  @PUT(EndPoints.resetPasswordEndpoint)
  Future<ResetPasswordResponse> resetPassword(
      @Body() ResetPasswordRequest request);
}
