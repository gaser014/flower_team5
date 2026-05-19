import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/config/uses_cases/use_cases.dart';
import 'package:flowers_app/features/reset_password/data/models/reset_password_request.dart';
import 'package:flowers_app/features/reset_password/domain/repositories/reset_password_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class ResetPasswordUseCase extends UseCase<bool, ResetPasswordRequest> {
  final ResetPasswordRepositoryContract _repository;
  
  const ResetPasswordUseCase(this._repository);
  
  @override
  Future<Result<bool>> call(ResetPasswordRequest params) async {
    return await _repository.resetPassword(params);
  }
}
