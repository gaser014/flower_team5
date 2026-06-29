import 'package:flowers_app/features/auth/sign_up/data/models/sign_up_request_dto.dart';
import 'package:flowers_app/features/auth/sign_up/data/models/sign_up_response_dto.dart';

abstract interface class SignUpRemoteDataSource {
  Future<SignUpResponseDto> signUp(SignUpRequestDto request);
}