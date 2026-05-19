import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/config/uses_cases/use_cases.dart';
import 'package:flowers_app/features/edit_profile/domain/repositories/edit_profile_repository.dart';
import 'package:flowers_app/features/login/domain/entities/user_entity.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class UploadPhotoUseCase extends UseCase<UserEntity?, String> {
  final EditProfileRepository _repository;

  const UploadPhotoUseCase(this._repository);

  @override
  Future<Result<UserEntity?>> call(String params) async {
    return await _repository.uploadPhoto(imagePath: params);
  }
}
