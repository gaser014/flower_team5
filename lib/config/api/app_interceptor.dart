import 'package:dio/dio.dart';
import 'package:flowers_app/config/dependency_injection/di.dart';
import 'package:flowers_app/config/api/api_key.dart';
import 'package:flowers_app/core/data/data_sources/auth_local_data_source.dart';
import 'package:flowers_app/core/values/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'status_code.dart';

@singleton
class AppInterceptors extends Interceptor {
  final Dio dio;
  final FlutterSecureStorage fss;

  AppInterceptors({required this.dio, required this.fss});

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    options.cancelToken = getIt<CancelToken>();
    String? authToken = await fss.read(key: AppStrings.token);
    authToken ??= await fss.read(key: APIkeys.accessToken);
    if (authToken != null && authToken.isNotEmpty) {
      options.headers['Authorization'] =
          'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjoiNjlmOWFkM2Y2YmJhZjE1ODhiYmRjYzE1Iiwicm9sZSI6InVzZXIiLCJpYXQiOjE3ODI0NjY3NDZ9.PpYUHHMpvs9ABXFtWw4_hrgru62XCdWIJeX7hEbw6Gk';
      // options.headers["token"] = authToken;
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    // ToDo
    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    debugPrint("err.response?.statusCode ${err.response?.statusCode}");
    if (err.response?.statusCode == StatusCode.expiredToken) {
      await getIt<AuthLocalDataSourceContract>().clearSession();
    }
    super.onError(err, handler);
  }
}
