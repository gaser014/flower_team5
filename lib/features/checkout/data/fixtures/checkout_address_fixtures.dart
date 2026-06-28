import 'package:flowers_app/core/values/app_strings.dart';
import 'package:flowers_app/features/checkout/domain/entities/checkout_address_entity.dart';

/// Seed addresses used until a real addresses feature/data source is wired in.
///
/// Coordinates are real so the checkout request carries a valid location
/// instead of the (0,0) `withoutLocation` fallback.
abstract final class CheckoutAddressFixtures {
  static const List<CheckoutAddressEntity> addresses = [
    CheckoutAddressEntity(
      id: 'home',
      label: AppStrings.homeLabel,
      address: '2XVP+XC - Sheikh Zayed',
      street: '2XVP+XC - Sheikh Zayed',
      phone: '+201000000000',
      city: 'Sheikh Zayed',
      lat: '30.0254',
      long: '30.9707',
    ),
    CheckoutAddressEntity(
      id: 'office',
      label: AppStrings.officeLabel,
      address: 'Plot 12 - 6th of October',
      street: 'Plot 12 - 6th of October',
      phone: '+201111111111',
      city: '6th of October',
      lat: '29.9627',
      long: '30.9376',
    ),
  ];
}
