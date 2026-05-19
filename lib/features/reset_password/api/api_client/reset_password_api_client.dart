import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:flowers_app/config/api/end_points.dart';
import 'package:flowers_app/features/reset_password/data/models/reset_password_request.dart';

import 'package:injectable/injectable.dart';

part 'reset_password_api_client.g.dart';

@Injectable()
@RestApi()
abstract class ResetPasswordApiClient {
  @factoryMethod
  factory ResetPasswordApiClient(Dio dio) = _ResetPasswordApiClient;

  @PATCH(EndPoints.changePassword)
  Future<dynamic> resetPassword(
    @Body() ResetPasswordRequest request,
  );
}
