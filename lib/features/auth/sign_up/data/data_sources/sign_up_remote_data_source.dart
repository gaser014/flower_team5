import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flowers_app/config/api/end_points.dart';
import 'package:flowers_app/features/auth/sign_up/data/models/sign_up_request_model.dart';
import 'package:flowers_app/features/auth/sign_up/data/models/sign_up_response_model.dart';
import 'package:injectable/injectable.dart';

abstract interface class SignUpRemoteDataSource {
  Future<SignUpResponseModel> signUp(SignUpRequestModel request);
}

@LazySingleton(as: SignUpRemoteDataSource)
class SignUpRemoteDataSourceImpl implements SignUpRemoteDataSource {
  final Dio _dio;

  SignUpRemoteDataSourceImpl(this._dio);

  @override
  Future<SignUpResponseModel> signUp(SignUpRequestModel request) async {
    final body = request.toJson();
    log("Request Body: $body");
    final response = await _dio.post(
      EndPoints.register,
      data: body,
    );
    return SignUpResponseModel.fromJson(response.data);
  }
}