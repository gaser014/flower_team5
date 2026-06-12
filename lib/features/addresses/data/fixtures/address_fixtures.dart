import 'package:flowers_app/features/addresses/domain/entities/address_entity.dart';

class AddressFixtures {
  AddressFixtures._();

  static List<AddressEntity> get dummyAddresses => List.generate(
    60,
    (index) => AddressEntity(
      id: '${index + 1}',
      street: 'Home ${index + 1}',
      phone: '01010700700 ${index + 1}',
      city: 'Gizaa ${index + 1}',
      lat: 'z ${index + 1}',
      long: 'z ${index + 1}',
      username: 'ahmedmuti ${index + 1}',
    ),
  );
}
