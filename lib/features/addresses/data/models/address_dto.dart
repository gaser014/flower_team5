import 'package:flowers_app/features/addresses/domain/entities/address_entity.dart';

class AddressDto {
  final String? id;
  final String? street;
  final String? phone;
  final String? city;
  final String? lat;
  final String? long;
  final String? username;

  const AddressDto({
    this.id,
    this.street,
    this.phone,
    this.city,
    this.lat,
    this.long,
    this.username,
  });

  factory AddressDto.fromJson(Map<String, dynamic> json) {
    return AddressDto(
      id: json['_id'],
      street: json['street'],
      phone: json['phone'],
      city: json['city'],
      lat: json['lat'],
      long: json['long'],
      username: json['username'],
    );
  }

  factory AddressDto.fromEntity(AddressEntity entity) {
    return AddressDto(
      id: entity.id,
      street: entity.street,
      phone: entity.phone,
      city: entity.city,
      lat: entity.lat,
      long: entity.long,
      username: entity.username,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'street': street,
      'phone': phone,
      'city': city,
      'lat': lat,
      'long': long,
      'username': username,
    };
  }

  AddressEntity toEntity() {
    return AddressEntity(
      id: id,
      street: street,
      phone: phone,
      city: city,
      lat: lat,
      long: long,
      username: username,
    );
  }
}
