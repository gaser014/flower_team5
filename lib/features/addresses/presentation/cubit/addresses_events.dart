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

