import 'package:flowers_app/features/location/domain/entities/location_entity.dart';

class LocationFixtures {
  LocationFixtures._();

  static const LocationEntity cairo = LocationEntity(
    latitude: 30.0444,
    longitude: 31.2357,
  );

  static const LocationEntity giza = LocationEntity(
    latitude: 30.0131,
    longitude: 31.2089,
  );

  static const LocationEntity alexandria = LocationEntity(
    latitude: 31.2001,
    longitude: 29.9187,
  );

  static const LocationEntity sheikhZayed = LocationEntity(
    latitude: 30.0626,
    longitude: 30.9845,
  );
}
