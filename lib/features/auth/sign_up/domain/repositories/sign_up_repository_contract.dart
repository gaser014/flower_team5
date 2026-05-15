import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/features/auth/sign_up/domain/entities/sign_up_entity.dart';
import 'package:flowers_app/features/auth/sign_up/domain/entities/user_entity.dart';

abstract interface class SignUpRepositoryContract {
  Future<Result<SignUpEntity>> signUp({required UserEntity userEntity});
}
