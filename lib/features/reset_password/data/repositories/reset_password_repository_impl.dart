import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/features/reset_password/api/api_client/reset_password_api_client.dart';
import 'package:flowers_app/features/reset_password/data/models/reset_password_request.dart';
import 'package:flowers_app/features/reset_password/domain/repositories/reset_password_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ResetPasswordRepositoryContract)
class ResetPasswordRepositoryImpl implements ResetPasswordRepositoryContract {
  final ResetPasswordApiClient _apiClient;
  
  ResetPasswordRepositoryImpl(this._apiClient);

  @override
  Future<Result<bool>> resetPassword(ResetPasswordRequest params) async {
    try {
      await _apiClient.resetPassword(params);
      return const Success(data: true);
    } on Exception catch (e) {
      return Error(exception: e);
    }
  }
}
