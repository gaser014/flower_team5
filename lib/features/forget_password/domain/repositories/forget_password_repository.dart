import 'package:flowers_app/config/base_response/result.dart';
import '../entities/forget_password_params.dart';

abstract class ForgetPasswordRepository {
  Future<Result<void>> sendForgetPasswordCode(ForgetPasswordParams params);

  Future<Result<void>> verifyForgetPasswordCode(ForgetPasswordParams params);

  Future<Result<void>> resetPassword(ForgetPasswordParams params);
}
