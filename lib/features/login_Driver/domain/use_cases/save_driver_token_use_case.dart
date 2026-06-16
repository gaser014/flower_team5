import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/config/uses_cases/use_cases.dart';
import 'package:flowers_app/features/login_Driver/domain/repositories/login_Driver_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class SaveDriverTokenUseCase extends UseCase<void, String> {
  final LoginDriverRepositoryContract _repository;
  const SaveDriverTokenUseCase(this._repository);

  @override
  Future<Result<void>> call(String token) async {
    return await _repository.saveDriverToken(token);
  }
}
