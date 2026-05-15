import '../models/forget_password_request.dart';
import '../models/verify_code_request.dart';
import '../models/reset_password_request.dart';
import '../models/forget_password_response_models.dart';

abstract interface class ForgetPasswordRemoteDataSourceContract {
  Future<ForgetPasswordResponse> sendForgetPasswordCode(
      ForgetPasswordRequest request);
  Future<ForgetPasswordResponse> verifyForgetPasswordCode(
      VerifyCodeRequest request);
  Future<ResetPasswordResponse> resetPassword(ResetPasswordRequest request);
}
