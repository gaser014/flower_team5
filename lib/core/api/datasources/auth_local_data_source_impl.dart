import 'dart:developer';
import 'package:flutter/foundation.dart';
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
      await Future.wait([
        fss.write(key: APIkeys.accessToken, value: token),
        fss.write(key: AppStrings.token, value: token),
      ]);
      if (kDebugMode) log("Token saved successfully");
    } catch (e) {
      if (kDebugMode) log("Error saving token: $e");
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
      if (kDebugMode) log("Error reading token: $e");
      return null;
    }
  }

  @override
  Future<void> deleteUserToken() async {
    try {
      await Future.wait([
        fss.delete(key: AppStrings.token),
        fss.delete(key: APIkeys.accessToken),
      ]);
      if (kDebugMode) log("Token deleted successfully");
    } catch (e) {
      if (kDebugMode) log("Error deleting token: $e");
    }
  }

  @override
  Future<void> clearSession() async {
    try {
      await Future.wait([
        deleteUserToken(),
        fss.delete(key: AppStrings.user),
        fss.delete(key: APIkeys.refreshToken),
        fss.delete(key: APIkeys.rememberMe),
      ]);
      if (kDebugMode) log("Session cleared successfully");
    } catch (e) {
      if (kDebugMode) log("Error clearing session: $e");
    }
  }
}
