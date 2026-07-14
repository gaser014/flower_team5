import 'package:flowers_app/config/api/api_execute.dart';
import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/core/data/data_sources/auth_local_data_source.dart';
import 'package:flowers_app/features/logout/data/datasources/logout_remote_data_source_contract.dart';
import 'package:flowers_app/features/logout/domain/repositories/logout_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: LogoutRepository)
class LogoutRepositoryImpl implements LogoutRepository {
  final LogoutRemoteDataSourceContract _remoteDataSource;
  final AuthLocalDataSourceContract _localDataSource;

  LogoutRepositoryImpl(this._remoteDataSource, this._localDataSource);

  @override
  Future<Result<void>> logout() async {
    final result = await executeApi<void>(() => _remoteDataSource.logout());
    await _localDataSource.clearSession();
    return result;
  }
}
