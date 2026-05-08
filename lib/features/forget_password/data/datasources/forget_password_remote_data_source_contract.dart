import '../models/forget_password_request_models.dart';
import '../models/forget_password_response_models.dart';

abstract class ForgetPasswordRemoteDataSourceContract {
  Future<ForgetPasswordResponse> sendForgetPasswordCode(
      ForgetPasswordRequest request);
  Future<ForgetPasswordResponse> verifyForgetPasswordCode(
      VerifyCodeRequest request);
  Future<ResetPasswordResponse> resetPassword(ResetPasswordRequest request);
}
