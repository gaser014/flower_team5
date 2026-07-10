import 'package:equatable/equatable.dart';

class CheckoutParams extends Equatable {
  final String street;
  final String phone;
  final String city;
  final String lat;
  final String long;

  const CheckoutParams({
    required this.street,
    required this.phone,
    required this.city,
    required this.lat,
    required this.long,
  });

  @override
  List<Object?> get props => [street, phone, city, lat, long];
}
