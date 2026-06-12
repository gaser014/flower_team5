import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/config/uses_cases/use_cases.dart';
import 'package:flowers_app/features/location/domain/repositories/location_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class RequestLocationPermissionUseCase extends UseCase<bool, NoParams> {
  final LocationRepository repository;

  RequestLocationPermissionUseCase(this.repository);

  @override
  Future<Result<bool>> call(NoParams parm) {
    return repository.requestLocationPermission();
  }
}
