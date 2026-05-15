import 'package:flowers_app/config/api/api_execute.dart';
import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/core/data/data_sources/auth_local_data_source.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entities/forget_password_params.dart';
import '../../domain/repositories/forget_password_repository.dart';
import '../datasources/forget_password_remote_data_source_contract.dart';
import '../models/forget_password_request.dart';
import '../models/verify_code_request.dart';
import '../models/reset_password_request.dart';

@Injectable(as: ForgetPasswordRepository)
class ForgetPasswordRepositoryImpl implements ForgetPasswordRepository {
  final ForgetPasswordRemoteDataSourceContract _remoteDataSource;
  final AuthLocalDataSourceContract _localDataSource;

  ForgetPasswordRepositoryImpl(
    this._remoteDataSource,
    this._localDataSource,
  );

  @override
  Future<Result<void>> sendForgetPasswordCode(ForgetPasswordParams params) {
    return executeApi(() async {
      await _remoteDataSource.sendForgetPasswordCode(
        ForgetPasswordRequest(email: params.email ?? ""),
      );
    });
  }

  @override
  Future<Result<void>> verifyForgetPasswordCode(ForgetPasswordParams params) {
    return executeApi(() async {
      await _remoteDataSource.verifyForgetPasswordCode(
        VerifyCodeRequest(resetCode: params.resetCode ?? ""),
      );
    });
  }

  @override
  Future<Result<void>> resetPassword(ForgetPasswordParams params) async {
    final result = await executeApi(() => _remoteDataSource.resetPassword(
          ResetPasswordRequest(
            email: params.email ?? "",
            newPassword: params.newPassword ?? "",
          ),
        ));

    if (result is Success) {
      final data = (result as Success).data;
      if (data?.token != null) {
        await _localDataSource.saveUserToken(data!.token!);
      }
      return const Success<void>();
    } else {
      return Error<void>(exception: (result as Error).exception);
    }
  }
}
