import 'package:flowers_app/config/base_response/result.dart';
import 'package:injectable/injectable.dart';
import '../entities/forget_password_params.dart';
import '../repositories/forget_password_repository.dart';

@injectable
class SendForgetPasswordCodeUseCase {
  final ForgetPasswordRepository _repository;

  SendForgetPasswordCodeUseCase(this._repository);

  Future<Result<void>> execute(ForgetPasswordParams params) {
    return _repository.sendForgetPasswordCode(params);
  }
}

@injectable
class VerifyForgetPasswordCodeUseCase {
  final ForgetPasswordRepository _repository;

  VerifyForgetPasswordCodeUseCase(this._repository);

  Future<Result<void>> execute(ForgetPasswordParams params) {
    return _repository.verifyForgetPasswordCode(params);
  }
}

@injectable
class ResetPasswordUseCase {
  final ForgetPasswordRepository _repository;

  ResetPasswordUseCase(this._repository);

  Future<Result<void>> execute(ForgetPasswordParams params) {
    return _repository.resetPassword(params);
  }
}
