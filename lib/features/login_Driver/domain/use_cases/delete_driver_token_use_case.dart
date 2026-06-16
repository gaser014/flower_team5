import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/config/uses_cases/use_cases.dart';
import 'package:flowers_app/features/login_Driver/domain/repositories/login_Driver_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class DeleteDriverTokenUseCase extends UseCase<void, NoParams> {
  final LoginDriverRepositoryContract _repository;
  const DeleteDriverTokenUseCase(this._repository);

  @override
  Future<Result<void>> call(NoParams params) async {
    return await _repository.deleteDriverToken();
  }
}
