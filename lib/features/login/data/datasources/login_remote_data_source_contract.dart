import 'package:flowers_app/config/uses_cases/login_params.dart';
import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/features/login/data/models/login_response_model.dart';

abstract interface class LoginRemoteDataSourceContract {
  Future<Result<LoginResponseModel>> login(LoginParams params);
}
