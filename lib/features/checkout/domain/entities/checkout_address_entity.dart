import 'package:equatable/equatable.dart';

/// A delivery address the user can pick on the checkout screen.
///
/// Carries everything the checkout API needs ([street], [phone], [city],
/// [lat], [long]) plus presentation fields ([label], [address]) so the
/// selected address can flow straight into [CheckoutParams] with real
/// coordinates instead of the `withoutLocation` (0,0) fallback.
class CheckoutAddressEntity extends Equatable {
  final String id;
  final String label;
  final String address;
  final String street;
  final String phone;
  final String city;
  final String lat;
  final String long;

  const CheckoutAddressEntity({
    required this.id,
    required this.label,
    required this.address,
    required this.street,
    required this.phone,
    required this.city,
    required this.lat,
    required this.long,
  });

  @override
  List<Object?> get props => [
    id,
    label,
    address,
    street,
    phone,
    city,
    lat,
    long,
  ];
}
