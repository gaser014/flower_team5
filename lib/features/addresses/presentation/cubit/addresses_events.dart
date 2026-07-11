part of 'addresses_cubit.dart';

sealed class AddressesEvents {
  const AddressesEvents();
}

class GetAddressesEvent extends AddressesEvents {
  const GetAddressesEvent();
}

class AddAddressEvent extends AddressesEvents {
  final AddressEntity entity;
  const AddAddressEvent({required this.entity});
}

class UpdateAddressEvent extends AddressesEvents {
  final AddressEntity entity;
  const UpdateAddressEvent({required this.entity});
}

class DeleteAddressEvent extends AddressesEvents {
  final String id;
  const DeleteAddressEvent({required this.id});
}

class UpdateFormCityEvent extends AddressesEvents {
  final GovernorateItem city;
  const UpdateFormCityEvent({required this.city});
}

class UpdateFormAreaEvent extends AddressesEvents {
  final AreaItem? area;
  const UpdateFormAreaEvent({required this.area});
}

class ResetFormEvent extends AddressesEvents {
  const ResetFormEvent();
}

 class InitFormEvent extends AddressesEvents {
  final AddressEntity? editAddress;
  const InitFormEvent({this.editAddress});
}

class UpdateFormLocationEvent extends AddressesEvents {
  final double? lat;
  final double? lng;
  final String? street;
  final GovernorateItem? city;
  final AreaItem? area;
  const UpdateFormLocationEvent({
    this.lat,
    this.lng,
    this.street,
    this.city,
    this.area,
  });
}
