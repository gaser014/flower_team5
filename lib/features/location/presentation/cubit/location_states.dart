import 'package:equatable/equatable.dart';
import 'package:flowers_app/features/addresses/domain/entities/address_entity.dart';

abstract class LocationState extends Equatable {
  const LocationState();

  @override
  List<Object?> get props => [];
}

class LocationInitial extends LocationState {}

class LocationLoading extends LocationState {}

class LocationLoaded extends LocationState {
  final AddressEntity selectedAddress;
  final List<AddressEntity> allAddresses;
  final bool isFromLocation;

  const LocationLoaded({
    required this.selectedAddress,
    required this.allAddresses,
    required this.isFromLocation,
  });

  LocationLoaded copyWith({
    AddressEntity? selectedAddress,
    List<AddressEntity>? allAddresses,
    bool? isFromLocation,
  }) {
    return LocationLoaded(
      selectedAddress: selectedAddress ?? this.selectedAddress,
      allAddresses: allAddresses ?? this.allAddresses,
      isFromLocation: isFromLocation ?? this.isFromLocation,
    );
  }

  @override
  List<Object?> get props => [selectedAddress, allAddresses, isFromLocation];
}

class LocationEmpty extends LocationState {
  final String message;

  const LocationEmpty({required this.message});

  @override
  List<Object?> get props => [message];
}

class LocationError extends LocationState {
  final String message;

  const LocationError({required this.message});

  @override
  List<Object?> get props => [message];
}
