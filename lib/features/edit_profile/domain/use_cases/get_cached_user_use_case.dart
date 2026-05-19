import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/config/uses_cases/use_cases.dart';
import 'package:flowers_app/features/edit_profile/domain/repositories/edit_profile_repository.dart';
import 'package:flowers_app/features/login/domain/entities/user_entity.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class GetCachedUserUseCase extends UseCase<UserEntity?, NoParams> {
  final EditProfileRepository _repository;

  const GetCachedUserUseCase(this._repository);

  @override
  Future<Result<UserEntity?>> call(NoParams params) async {
    return await _repository.getCachedUser();
  }
}
