import 'package:equatable/equatable.dart';
import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/config/uses_cases/use_cases.dart';
import 'package:flowers_app/features/auth/sign_up/domain/entities/sign_up_entity.dart';
import 'package:flowers_app/features/auth/sign_up/domain/entities/user_entity.dart';
import 'package:flowers_app/features/auth/sign_up/domain/repositories/sign_up_repository_contract.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SignUpUseCase extends UseCase<SignUpEntity, UserEntity> {
  final SignUpRepositoryContract _signUpRepo;

  const SignUpUseCase(this._signUpRepo);

  @override
  Future<Result<SignUpEntity>> call(UserEntity params) async {
    return await _signUpRepo.signUp(userEntity: params);
  }
}
