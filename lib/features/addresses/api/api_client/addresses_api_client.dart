import 'package:dio/dio.dart';
import 'package:flowers_app/config/api/end_points.dart';
import 'package:flowers_app/features/addresses/data/models/address_dto.dart';
import 'package:flowers_app/features/addresses/data/models/addresses_response_dto.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

part 'addresses_api_client.g.dart';

@lazySingleton
@RestApi(baseUrl: EndPoints.baseUrl)
abstract interface class AddressesApiClient {
  @factoryMethod
  factory AddressesApiClient(Dio dio) => _AddressesApiClient(dio);

  @GET(EndPoints.addressEndPoint)
  Future<AddressesResponseDto> getAddresses();

  @PATCH(EndPoints.addressEndPoint)
  Future<AddressesResponseDto> addAddress(@Body() AddressDto address);

  @PATCH('${EndPoints.addressEndPoint}/{addressId}')
  Future<AddressesResponseDto> updateAddress(
    @Path('addressId') String addressId,
    @Body() AddressDto address,
  );

  @DELETE('${EndPoints.addressEndPoint}/{addressId}')
  Future<AddressesResponseDto> deleteAddress(
    @Path('addressId') String addressId,
  );
}
