import 'package:flowers_app/features/home/domain/entities/home_entity.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class HomeModule {
  final HomeEntity? homeData;
  HomeModule(this.homeData);
}
