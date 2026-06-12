import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/features/addresses/domain/entities/address_entity.dart';

abstract interface class AddressesRepository {
  Future<Result<List<AddressEntity>>> getAddresses();

  Future<Result<List<AddressEntity>>> addAddress({
    required AddressEntity address,
  });

  Future<Result<List<AddressEntity>>> updateAddress({
    required AddressEntity address,
  });

  Future<Result<List<AddressEntity>>> deleteAddress({
    required String addressId,
  });
}
