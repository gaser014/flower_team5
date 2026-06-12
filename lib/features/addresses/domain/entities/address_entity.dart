import 'package:equatable/equatable.dart';

class AddressEntity extends Equatable {
  final String? id;
  final String? street;
  final String? phone;
  final String? city;
  final String? lat;
  final String? long;
  final String? username;

  const AddressEntity({
    this.id,
    this.street,
    this.phone,
    this.city,
    this.lat,
    this.long,
    this.username,
  });

  AddressEntity copyWith({
    String? id,
    String? street,
    String? phone,
    String? city,
    String? lat,
    String? long,
    String? username,
  }) {
    return AddressEntity(
      id: id ?? this.id,
      street: street ?? this.street,
      phone: phone ?? this.phone,
      city: city ?? this.city,
      lat: lat ?? this.lat,
      long: long ?? this.long,
      username: username ?? this.username,
    );
  }

  @override
  List<Object?> get props => [
        id,
        street,
        phone,
        city,
        lat,
        long,
        username,
      ];
}
