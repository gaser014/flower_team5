import 'package:flowers_app/config/base_response/result.dart';

abstract interface class LogoutRepository {
  Future<Result<void>> logout();
}
