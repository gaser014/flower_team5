import 'package:dio/dio.dart';
import 'package:flowers_app/config/api/end_points.dart';
import 'package:flowers_app/features/auth/sign_up/data/models/sign_up_request_dto.dart';
import 'package:flowers_app/features/auth/sign_up/data/models/sign_up_response_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'sign_up_api_client.g.dart';

@injectable
@RestApi(baseUrl: EndPoints.baseUrl)
abstract class SignUpApiClient {
  @factoryMethod
  factory SignUpApiClient(Dio dio) = _SignUpApiClient;

  @POST(EndPoints.register)
  Future<SignUpResponseDto> signUp(@Body() SignUpRequestDto request);
}
