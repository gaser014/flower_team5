import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/features/login_Driver/domain/repositories/login_Driver_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class SaveDriverCredentialsUseCase {
  final LoginDriverRepositoryContract _repository;
  const SaveDriverCredentialsUseCase(this._repository);

  Future<Result<void>> call({
    required String email,
    required String password,
  }) async {
    return await _repository.saveCredentials(email: email, password: password);
  }
}
