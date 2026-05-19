import 'package:flowers_app/features/reset_password/data/models/reset_password_request.dart';

sealed class ResetPasswordEvents {}

class SubmitResetPasswordEvent extends ResetPasswordEvents {
  final ResetPasswordRequest params;
  SubmitResetPasswordEvent(this.params);
}
