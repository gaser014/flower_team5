import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/config/uses_cases/params.dart';
import 'package:flowers_app/config/uses_cases/use_cases.dart';
import 'package:flowers_app/features/addresses/domain/entities/address_entity.dart';
import 'package:flowers_app/features/location/domain/entities/location_entity.dart';
import 'package:flowers_app/features/location/domain/repositories/location_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable()
class GetNearestAddressUseCase
    extends UseCase<AddressEntity?, GetNearestAddressParams> {
  final LocationRepository _locationRepository;

  GetNearestAddressUseCase(this._locationRepository);

  @override
  Future<Result<AddressEntity?>> call(GetNearestAddressParams params) async {
    try {
      if (params.addresses.isEmpty) {
        return const Success(data: null);
      }

      AddressEntity? nearestAddress;
      double minDistance = double.infinity;

      for (final address in params.addresses) {
        if (address.lat == null || address.long == null) continue;

        final addressLat = double.tryParse(address.lat!);
        final addressLong = double.tryParse(address.long!);

        if (addressLat == null || addressLong == null) continue;

        final distance = _locationRepository.calculateDistance(
          startLatitude: params.currentLocation.latitude,
          startLongitude: params.currentLocation.longitude,
          endLatitude: addressLat,
          endLongitude: addressLong,
        );

        if (distance < minDistance) {
          minDistance = distance;
          nearestAddress = address;
        }
      }

      return Success(data: nearestAddress);
    } catch (e) {
      return Error(exception: Exception(e.toString()));
    }
  }
}

class GetNearestAddressParams extends Params {
  final LocationEntity currentLocation;
  final List<AddressEntity> addresses;

  const GetNearestAddressParams({
    required this.currentLocation,
    required this.addresses,
  });

  @override
  List<Object?> get props => [currentLocation, addresses];
}
