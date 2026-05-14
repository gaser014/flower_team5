import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/features/home/data/models/home_dto.dart';

abstract interface class HomeRemoteDataSourceContract {
  Future<Result<HomeDto>> getHomeData();
}
