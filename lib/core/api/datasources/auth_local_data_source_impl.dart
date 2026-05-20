import 'dart:developer';
import 'package:flowers_app/config/api/api_key.dart';
import 'package:flowers_app/core/data/data_sources/auth_local_data_source.dart';
import 'package:flowers_app/core/values/app_strings.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AuthLocalDataSourceContract)
class AuthLocalDataSourceImpl implements AuthLocalDataSourceContract {
  final FlutterSecureStorage fss;

  AuthLocalDataSourceImpl({required this.fss});

  @override
  Future<void> saveUserToken(String token) async {
    try {
      await fss.write(key: APIkeys.accessToken, value: token);
      await fss.write(key: AppStrings.token, value: token);
      log("Token saved successfully");
    } catch (e) {
      log("Error saving token: $e");
    }
  }

  @override
  Future<String?> getUserToken() async {
    try {
      final token = await fss.read(key: AppStrings.token);
      if (token != null && token.isNotEmpty) {
        return token;
      }
      return await fss.read(key: APIkeys.accessToken);
    } catch (e) {
      log("Error reading token: $e");
      return null;
    }
  }

  @override
  Future<void> deleteUserToken() async {
    try {
      await fss.delete(key: AppStrings.token);
      await fss.delete(key: APIkeys.accessToken);
      log("Token deleted successfully");
    } catch (e) {
      log("Error deleting token: $e");
    }
  }

  @override
  Future<void> clearSession() async {
    try {
      await deleteUserToken();
      await fss.delete(key: AppStrings.user);
      await fss.delete(key: APIkeys.refreshToken);
      await fss.delete(key: APIkeys.rememberMe);
      log("Session cleared successfully");
    } catch (e) {
      log("Error clearing session: $e");
    }
  }
}
