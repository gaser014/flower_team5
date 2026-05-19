import 'package:flowers_app/features/login/data/models/user_model.dart';

abstract interface class EditProfileLocalDataSourceContract {
  Future<void> saveUser(UserModel user);
  Future<UserModel?> getUser();
}
