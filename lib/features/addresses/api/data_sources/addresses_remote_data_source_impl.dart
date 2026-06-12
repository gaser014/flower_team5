import 'package:flowers_app/config/api/api_execute.dart';
import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/features/addresses/api/api_client/addresses_api_client.dart';
import 'package:flowers_app/features/addresses/data/data_sources/addresses_remote_data_source_contract.dart';
import 'package:flowers_app/features/addresses/data/models/address_dto.dart';
import 'package:flowers_app/features/addresses/data/models/addresses_response_dto.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AddressesRemoteDataSourceContract)
class AddressesRemoteDataSourceImpl
    implements AddressesRemoteDataSourceContract {
  final AddressesApiClient apiClient;

  AddressesRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<Result<AddressesResponseDto>> getAddresses() async {
    return await executeApi<AddressesResponseDto>(
      () => apiClient.getAddresses(),
    );
  }

  @override
  Future<Result<AddressesResponseDto>> addAddress({
    required AddressDto address,
  }) async {
    return await executeApi<AddressesResponseDto>(
      () => apiClient.addAddress(address),
    );
  }

  @override
  Future<Result<AddressesResponseDto>> updateAddress({
    required String addressId,
    required AddressDto address,
  }) async {
    return await executeApi<AddressesResponseDto>(
      () => apiClient.updateAddress(addressId, address),
    );
  }

  @override
  Future<Result<AddressesResponseDto>> deleteAddress({
    required String addressId,
  }) async {
    return await executeApi<AddressesResponseDto>(
      () => apiClient.deleteAddress(addressId),
    );
  }
}
