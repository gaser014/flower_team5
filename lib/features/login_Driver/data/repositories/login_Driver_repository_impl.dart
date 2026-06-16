import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/config/uses_cases/login_params.dart';
import 'package:flowers_app/features/login_Driver/data/datasources/login_Driver_local_data_source_contract.dart';
import 'package:flowers_app/features/login_Driver/data/datasources/login_Driver_remote_data_source_contract.dart';
import 'package:flowers_app/features/login_Driver/domain/entities/driver_login_response_entity.dart';
import 'package:flowers_app/features/login_Driver/domain/repositories/login_Driver_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: LoginDriverRepositoryContract)
class LoginDriverRepositoryImpl implements LoginDriverRepositoryContract {
  final LoginDriverRemoteDataSourceContract _remote;
  final LoginDriverLocalDataSourceContract _local;

  const LoginDriverRepositoryImpl(this._remote, this._local);

  @override
  Future<Result<DriverLoginResponseEntity>> loginDriver(
    LoginParams params,
  ) async {
    final result = await _remote.loginDriver(params);
    return result.when(
      success: (response) {
        return Success<DriverLoginResponseEntity>(data: response?.toEntity());
      },
      error: (error) => Error(exception: error),
    );
  }

  @override
  Future<Result<void>> saveDriverToken(String token) async {
    try {
      await _local.saveDriverToken(token);
      return const Success(data: null);
    } on Exception catch (e) {
      return Error(exception: e);
    }
  }

  @override
  Future<Result<void>> deleteDriverToken() async {
    try {
      await _local.deleteDriverToken();
      return const Success(data: null);
    } on Exception catch (e) {
      return Error(exception: e);
    }
  }

  @override
  Future<Result<void>> saveCredentials({
    required String email,
    required String password,
  }) async {
    try {
      await _local.saveCredentials(email: email, password: password);
      return const Success(data: null);
    } on Exception catch (e) {
      return Error(exception: e);
    }
  }

  @override
  Future<Result<void>> deleteCredentials() async {
    try {
      await _local.deleteCredentials();
      return const Success(data: null);
    } on Exception catch (e) {
      return Error(exception: e);
    }
  }

  @override
  Future<Result<Map<String, String?>>> getSavedCredentials() async {
    try {
      final credentials = await _local.getSavedCredentials();
      return Success(data: credentials);
    } on Exception catch (e) {
      return Error(exception: e);
    }
  }
}
