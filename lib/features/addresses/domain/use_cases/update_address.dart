import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/config/uses_cases/use_cases.dart';
import 'package:flowers_app/features/addresses/domain/entities/address_entity.dart';
import 'package:flowers_app/features/addresses/domain/repositories/addresses_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class UpdateAddressUseCase extends UseCase<List<AddressEntity>, AddressEntity> {
  final AddressesRepository repository;

  UpdateAddressUseCase(this.repository);

  @override
  Future<Result<List<AddressEntity>>> call(AddressEntity parm) {
    return repository.updateAddress(address: parm);
  }
}
