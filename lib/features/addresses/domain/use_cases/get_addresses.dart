import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/config/uses_cases/use_cases.dart';
import 'package:flowers_app/features/addresses/domain/entities/address_entity.dart';
import 'package:flowers_app/features/addresses/domain/repositories/addresses_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class GetAddressesUseCase extends UseCase<List<AddressEntity>, NoParams> {
  final AddressesRepository repository;

  GetAddressesUseCase(this.repository);

  @override
  Future<Result<List<AddressEntity>>> call(NoParams parm) {
    return repository.getAddresses();
  }
}
