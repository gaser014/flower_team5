import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/config/uses_cases/use_cases.dart';
import 'package:flowers_app/features/addresses/domain/entities/address_entity.dart';
import 'package:flowers_app/features/addresses/domain/repositories/addresses_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class DeleteAddressUseCase extends UseCase<List<AddressEntity>, String> {
  final AddressesRepository repository;

  DeleteAddressUseCase(this.repository);

  @override
  Future<Result<List<AddressEntity>>> call(String parm) {
    return repository.deleteAddress(addressId: parm);
  }
}
