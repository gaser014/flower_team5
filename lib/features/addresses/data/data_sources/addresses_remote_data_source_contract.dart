import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/features/addresses/data/models/address_dto.dart';
import 'package:flowers_app/features/addresses/data/models/addresses_response_dto.dart';

abstract interface class AddressesRemoteDataSourceContract {
  Future<Result<AddressesResponseDto>> getAddresses();

  Future<Result<AddressDto>> addAddress({required AddressDto address});

  Future<Result<AddressDto>> updateAddress({required AddressDto address});

  Future<Result<void>> deleteAddress({required String addressId});
}
