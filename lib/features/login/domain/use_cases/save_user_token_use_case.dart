import 'package:flowers_app/core/data/data_sources/auth_local_data_source.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class SaveUserTokenUseCase {
  final AuthLocalDataSourceContract _authLocalDataSourceContract;

  const SaveUserTokenUseCase(this._authLocalDataSourceContract);

  Future<void> call(String token) async {
    await _authLocalDataSourceContract.saveUserToken(token);
  }
}
