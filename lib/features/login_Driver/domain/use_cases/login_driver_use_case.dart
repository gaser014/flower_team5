import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/config/uses_cases/login_params.dart';
import 'package:flowers_app/config/uses_cases/use_cases.dart';
import 'package:flowers_app/features/login_Driver/domain/entities/driver_login_response_entity.dart';
import 'package:flowers_app/features/login_Driver/domain/repositories/login_Driver_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class LoginDriverUseCase
    extends UseCase<DriverLoginResponseEntity, LoginParams> {
  final LoginDriverRepositoryContract _repository;
  const LoginDriverUseCase(this._repository);

  @override
  Future<Result<DriverLoginResponseEntity>> call(LoginParams params) async {
    return await _repository.loginDriver(params);
  }
}
