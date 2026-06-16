import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/features/login_Driver/domain/repositories/login_Driver_repository.dart';
import 'package:flowers_app/config/uses_cases/use_cases.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class GetDriverCredentialsUseCase
    extends UseCase<Map<String, String?>, NoParams> {
  final LoginDriverRepositoryContract _repository;
  const GetDriverCredentialsUseCase(this._repository);

  @override
  Future<Result<Map<String, String?>>> call(NoParams params) async {
    return await _repository.getSavedCredentials();
  }
}
