import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/config/uses_cases/use_cases.dart';
import 'package:flowers_app/features/location/domain/entities/location_entity.dart';
import 'package:flowers_app/features/location/domain/repositories/location_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class GetCurrentLocationUseCase extends UseCase<LocationEntity, NoParams> {
  final LocationRepository repository;

  GetCurrentLocationUseCase(this.repository);

  @override
  Future<Result<LocationEntity>> call(NoParams parm) {
    return repository.getCurrentLocation();
  }
}
