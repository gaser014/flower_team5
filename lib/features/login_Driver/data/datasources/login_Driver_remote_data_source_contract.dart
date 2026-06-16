import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/config/uses_cases/login_params.dart';
import 'package:flowers_app/features/login_Driver/data/models/driver_login_response_model.dart';

abstract interface class LoginDriverRemoteDataSourceContract {
  Future<Result<DriverLoginResponseModel>> loginDriver(LoginParams params);
}
