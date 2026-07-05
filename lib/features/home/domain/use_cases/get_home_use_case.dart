import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/config/uses_cases/use_cases.dart';
import 'package:flowers_app/features/home/domain/entities/home_entity.dart';
import 'package:flowers_app/features/home/domain/repositories/home_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetHomeUseCase extends UseCase<HomeEntity, NoParams> {
  final HomeRepository _repository;

  GetHomeUseCase(this._repository);

  @override
  Future<Result<HomeEntity>> call(NoParams params) {
    return _repository.getHomeData();
  }
}
