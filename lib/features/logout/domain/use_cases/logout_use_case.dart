import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/features/logout/domain/repositories/logout_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class LogoutUseCase {
  final LogoutRepository _logoutRepository;

  const LogoutUseCase(this._logoutRepository);

  Future<Result<void>> call() {
    return _logoutRepository.logout();
  }
}
