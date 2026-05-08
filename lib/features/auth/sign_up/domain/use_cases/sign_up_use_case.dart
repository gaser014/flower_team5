import 'package:equatable/equatable.dart';
import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/config/uses_cases/use_cases.dart';
import 'package:flowers_app/features/auth/sign_up/domain/entities/sign_up_entity.dart';
import 'package:flowers_app/features/auth/sign_up/domain/repositories/sign_up_repository_contract.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SignUpUseCase extends UseCase<SignUpEntity, SignUpParams> {
  final SignUpRepositoryContract _signUpRepo;

  const SignUpUseCase(this._signUpRepo);

  @override
  Future<Result<SignUpEntity>> call(SignUpParams params) async {
    return await _signUpRepo.signUp(
      firstName: params.firstName,
      lastName: params.lastName,
      email: params.email,
      password: params.password,
      rePassword: params.rePassword,
      phone: params.phone,
      gender: params.gender,
    );
  }
}

class SignUpParams extends Equatable {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String rePassword;
  final String phone;
  final String gender;

  const SignUpParams({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.rePassword,
    required this.phone,
    required this.gender,
  });

  @override
  List<Object?> get props => [
        firstName,
        lastName,
        email,
        password,
        rePassword,
        phone,
        gender,
      ];
}
