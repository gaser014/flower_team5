import 'package:flowers_app/features/edit_profile/data/datasources/edit_profile_local_data_source_contract.dart';
import 'package:flowers_app/features/login/data/datasources/login_local_data_source_contract.dart';
import 'package:flowers_app/features/login/data/models/user_model.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: EditProfileLocalDataSourceContract)
class EditProfileLocalDataSourceImpl implements EditProfileLocalDataSourceContract {
  final LoginLocalDataSourceContract _loginLocalDataSourceContract;

  const EditProfileLocalDataSourceImpl(this._loginLocalDataSourceContract);

  @override
  Future<void> saveUser(UserModel user) async {
    await _loginLocalDataSourceContract.saveUser(user);
  }

  @override
  Future<UserModel?> getUser() async {
    return await _loginLocalDataSourceContract.getUser();
  }
}
