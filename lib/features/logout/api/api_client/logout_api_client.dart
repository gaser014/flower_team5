import 'package:dio/dio.dart';
import 'package:flowers_app/config/api/end_points.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'logout_api_client.g.dart';

@Injectable()
@RestApi()
abstract class LogoutApiClient {
  @factoryMethod
  factory LogoutApiClient(Dio dio) = _LogoutApiClient;

  @POST(EndPoints.logout)
  Future<dynamic> logout();
}
