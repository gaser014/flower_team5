import 'package:flowers_app/features/auth/sign_up/api/api_client/sign_up_api_client.dart';
import 'package:flowers_app/features/auth/sign_up/data/data_sources/sign_up_remote_data_source.dart';
import 'package:flowers_app/features/auth/sign_up/data/models/sign_up_request_dto.dart';
import 'package:flowers_app/features/auth/sign_up/data/models/sign_up_response_dto.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: SignUpRemoteDataSource)
class SignUpRemoteDataSourceImpl implements SignUpRemoteDataSource {
  final SignUpApiClient _apiClient;

  SignUpRemoteDataSourceImpl(this._apiClient);

  @override
  Future<SignUpResponseDto> signUp(SignUpRequestDto request) async {
    return await _apiClient.signUp(request);
  }
}
