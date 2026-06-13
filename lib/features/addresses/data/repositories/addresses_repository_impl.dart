import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/features/addresses/data/data_sources/addresses_remote_data_source_contract.dart';
import 'package:flowers_app/features/addresses/data/models/address_dto.dart';
import 'package:flowers_app/features/addresses/domain/entities/address_entity.dart';
import 'package:flowers_app/features/addresses/domain/repositories/addresses_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AddressesRepository)
class AddressesRepositoryImpl implements AddressesRepository {
  final AddressesRemoteDataSourceContract addressesRemoteDataSourceContract;

  AddressesRepositoryImpl({required this.addressesRemoteDataSourceContract});

  @override
  Future<Result<List<AddressEntity>>> getAddresses() async {
    final result = await addressesRemoteDataSourceContract.getAddresses();
    return result.when(
      success: (data) => Success(data: data?.toEntities()),
      error: (exception) => Error(exception: exception),
    );
  }

  @override
  Future<Result<List<AddressEntity>>> addAddress({
    required AddressEntity address,
  }) async {
    final result = await addressesRemoteDataSourceContract.addAddress(
      address: AddressDto.fromEntity(address),
    );
    return result.when(
      success: (data) => Success(data: data?.toEntities()),
      error: (exception) => Error(exception: exception),
    );
  }

  @override
  Future<Result<List<AddressEntity>>> updateAddress({
    required AddressEntity address,
  }) async {
    final dto = AddressDto.fromEntity(address);
    final result = await addressesRemoteDataSourceContract.updateAddress(
      addressId: address.id ?? '',
      address: dto,
    );
    return result.when(
      success: (data) => Success(data: data?.toEntities()),
      error: (exception) => Error(exception: exception),
    );
  }

  @override
  Future<Result<List<AddressEntity>>> deleteAddress({
    required String addressId,
  }) async {
    final result = await addressesRemoteDataSourceContract.deleteAddress(
      addressId: addressId,
    );
    return result.when(
      success: (data) => Success(data: data?.toEntities()),
      error: (exception) => Error(exception: exception),
    );
  }
}
