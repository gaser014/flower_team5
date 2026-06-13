class CheckoutRequestDto {
  final ShippingAddressDto shippingAddress;

  CheckoutRequestDto({required this.shippingAddress});

  factory CheckoutRequestDto.fromJson(Map<String, dynamic> json) =>
      CheckoutRequestDto(
        shippingAddress:
            ShippingAddressDto.fromJson(json['shippingAddress']),
      );

  Map<String, dynamic> toJson() => {
        'shippingAddress': shippingAddress.toJson(),
      };
}

class ShippingAddressDto {
  final String street;
  final String phone;
  final String city;
  final String lat;
  final String long;

  ShippingAddressDto({
    required this.street,
    required this.phone,
    required this.city,
    required this.lat,
    required this.long,
  });

  factory ShippingAddressDto.fromJson(Map<String, dynamic> json) =>
      ShippingAddressDto(
        street: json['street'],
        phone: json['phone'],
        city: json['city'],
        lat: json['lat'],
        long: json['long'],
      );

  Map<String, dynamic> toJson() => {
        'street': street,
        'phone': phone,
        'city': city,
        'long': long,
        'lat': lat,
      };
}
