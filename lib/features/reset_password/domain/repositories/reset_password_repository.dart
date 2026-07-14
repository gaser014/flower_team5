import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/features/reset_password/data/models/reset_password_request.dart';

abstract class ResetPasswordRepositoryContract {
  Future<Result<bool>> resetPassword(ResetPasswordRequest params);
}
