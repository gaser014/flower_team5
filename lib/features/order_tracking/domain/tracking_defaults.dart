import 'package:flowers_app/features/order_tracking/domain/entities/lat_lng_entity.dart';

abstract class TrackingDefaults {
  TrackingDefaults._();

  static const LatLngEntity storeLocation = LatLngEntity(
    lat: 30.9456534,
    lng: 31.2922893,
  );

  static const double averageSpeedKmh = 22;
}
