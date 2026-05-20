import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/config/uses_cases/use_cases.dart';
import 'package:flowers_app/features/logout/domain/repositories/logout_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class LogoutUseCase implements UseCase<void, NoParams> {
  final LogoutRepository _logoutRepository;

  const LogoutUseCase(this._logoutRepository);

  @override
  Future<Result<void>> call(NoParams params) async {
    return await _logoutRepository.logout();
  }
}
