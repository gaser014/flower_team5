import 'package:flowers_app/features/addresses/data/models/address_dto.dart';
import 'package:flowers_app/features/addresses/domain/entities/address_entity.dart';

class AddressesResponseDto {
  final String? message;
  final List<AddressDto>? addresses;

  const AddressesResponseDto({
    this.message,
    this.addresses,
  });

  factory AddressesResponseDto.fromJson(Map<String, dynamic> json) {
    return AddressesResponseDto(
      message: json['message'],
      addresses: (json['addresses'] as List?)
          ?.map((e) => AddressDto.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'addresses': addresses?.map((e) => e.toJson()).toList(),
    };
  }

  List<AddressEntity> toEntities() {
    return addresses?.map((dto) => dto.toEntity()).toList() ?? [];
  }
}
