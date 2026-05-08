import 'package:injectable/injectable.dart';
import '../../data/datasources/forget_password_remote_data_source_contract.dart';
import '../../data/models/forget_password_request_models.dart';
import '../../data/models/forget_password_response_models.dart';
import '../api_client/forget_password_api_client.dart';

@LazySingleton(as: ForgetPasswordRemoteDataSourceContract)
class ForgetPasswordRemoteDataSourceImpl
    implements ForgetPasswordRemoteDataSourceContract {
  final ForgetPasswordApiClient _apiClient;

  ForgetPasswordRemoteDataSourceImpl(this._apiClient);

  @override
  Future<ForgetPasswordResponse> sendForgetPasswordCode(
      ForgetPasswordRequest request) {
    return _apiClient.sendForgetPasswordCode(request);
  }

  @override
  Future<ForgetPasswordResponse> verifyForgetPasswordCode(
      VerifyCodeRequest request) {
    return _apiClient.verifyForgetPasswordCode(request);
  }

  @override
  Future<ResetPasswordResponse> resetPassword(ResetPasswordRequest request) {
    return _apiClient.resetPassword(request);
  }
}
