import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/config/uses_cases/use_cases.dart';
import 'package:flowers_app/features/edit_profile/domain/repositories/edit_profile_repository.dart';
import 'package:flowers_app/features/login/domain/entities/user_entity.dart';
import 'package:injectable/injectable.dart';

class EditProfileParams {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String gender;

  const EditProfileParams({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.gender,
  });
}

@Injectable()
class EditProfileUseCase extends UseCase<UserEntity?, EditProfileParams> {
  final EditProfileRepository _repository;

  const EditProfileUseCase(this._repository);

  @override
  Future<Result<UserEntity?>> call(EditProfileParams params) async {
    return await _repository.editProfile(
      firstName: params.firstName,
      lastName: params.lastName,
      email: params.email,
      phone: params.phone,
      gender: params.gender,
    );
  }
}
