import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/features/auth/sign_up/domain/entities/sign_up_entity.dart';

abstract interface class SignUpRepositoryContract {
  Future<Result<SignUpEntity>> signUp({
    required String firstName,
    required String lastName,
    required String email,
    required String password,
    required String rePassword,
    required String phone,
    required String gender,
  });
}
