import 'package:flowers_app/features/logout/api/api_client/logout_api_client.dart';
import 'package:flowers_app/features/logout/data/datasources/logout_remote_data_source_contract.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: LogoutRemoteDataSourceContract)
class LogoutRemoteDataSourceImpl implements LogoutRemoteDataSourceContract {
  final LogoutApiClient _apiClient;

  LogoutRemoteDataSourceImpl(this._apiClient);

  @override
  Future<void> logout() async {
    await _apiClient.logout();
  }
}
