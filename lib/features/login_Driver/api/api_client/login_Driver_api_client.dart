import 'package:dio/dio.dart';
import 'package:flowers_app/config/api/end_points.dart';
import 'package:flowers_app/features/login_Driver/data/models/driver_login_response_model.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'login_Driver_api_client.g.dart';

@Injectable()
@RestApi()
abstract class LoginDriverApiClient {
  @factoryMethod
  factory LoginDriverApiClient(Dio dio) = _LoginDriverApiClient;

  @POST(EndPoints.loginDriver)
  Future<DriverLoginResponseModel> loginDriver(
    @Field() String email,
    @Field() String password,
  );
}
