import 'package:flowers_app/config/api/api_execute.dart';
import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/config/uses_cases/login_params.dart';
import 'package:flowers_app/features/login_Driver/api/api_client/login_Driver_api_client.dart';
import 'package:flowers_app/features/login_Driver/data/datasources/login_Driver_remote_data_source_contract.dart';
import 'package:flowers_app/features/login_Driver/data/models/driver_login_response_model.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: LoginDriverRemoteDataSourceContract)
class LoginDriverRemoteDataSourceImpl
    implements LoginDriverRemoteDataSourceContract {
  final LoginDriverApiClient _apiClient;
  const LoginDriverRemoteDataSourceImpl(this._apiClient);

  @override
  Future<Result<DriverLoginResponseModel>> loginDriver(
    LoginParams params,
  ) async {
    return await executeApi(() async {
      return await _apiClient.loginDriver(params.email, params.password);
    });
  }
}
