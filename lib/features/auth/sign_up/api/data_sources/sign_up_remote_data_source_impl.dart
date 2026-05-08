import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flowers_app/config/api/end_points.dart';
import 'package:flowers_app/features/auth/sign_up/data/data_sources/sign_up_remote_data_source.dart';
import 'package:flowers_app/features/auth/sign_up/data/models/sign_up_request_dto.dart';
import 'package:flowers_app/features/auth/sign_up/data/models/sign_up_response_dto.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: SignUpRemoteDataSource)
class SignUpRemoteDataSourceImpl implements SignUpRemoteDataSource {
  final Dio _dio;

  SignUpRemoteDataSourceImpl(this._dio);

  @override
  Future<SignUpResponseDto> signUp(SignUpRequestDto request) async {
    final body = request.toJson();
    log("Request Body: $body");
    final response = await _dio.post(
      EndPoints.register,
      data: body,
    );
    return SignUpResponseDto.fromJson(response.data);
  }
}
