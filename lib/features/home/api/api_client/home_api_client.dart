import 'package:dio/dio.dart';
import 'package:flowers_app/config/api/end_points.dart';
import 'package:flowers_app/features/home/data/models/home_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'home_api_client.g.dart';

@Injectable()
@RestApi(baseUrl: EndPoints.baseUrl)
abstract interface class HomeApiClient {
  @factoryMethod
  factory HomeApiClient(Dio dio) => _HomeApiClient(dio);

  @GET(EndPoints.homeEndpoint)
  Future<HomeDto> getHomeData();
}
