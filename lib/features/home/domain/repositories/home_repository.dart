import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/features/home/domain/entities/home_entity.dart';

abstract interface class HomeRepository {
  Future<Result<HomeEntity>> getHomeData();
}
