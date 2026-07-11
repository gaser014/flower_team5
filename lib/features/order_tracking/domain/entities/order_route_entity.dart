import 'package:equatable/equatable.dart';
import 'package:flowers_app/features/order_tracking/domain/entities/lat_lng_entity.dart';

class OrderRouteEntity extends Equatable {
  final LatLngEntity? storeLocation;

  final LatLngEntity? userLocation;

  final List<LatLngEntity> polyline;

  final String distanceText;

  final String durationText;

  final bool isFallbackRoute;

  const OrderRouteEntity({
    this.storeLocation,
    this.userLocation,
    this.polyline = const [],
    this.distanceText = '',
    this.durationText = '',
    this.isFallbackRoute = false,
  });

  OrderRouteEntity copyWith({
    LatLngEntity? storeLocation,
    LatLngEntity? userLocation,
    List<LatLngEntity>? polyline,
    String? distanceText,
    String? durationText,
    bool? isFallbackRoute,
  }) {
    return OrderRouteEntity(
      storeLocation: storeLocation ?? this.storeLocation,
      userLocation: userLocation ?? this.userLocation,
      polyline: polyline ?? this.polyline,
      distanceText: distanceText ?? this.distanceText,
      durationText: durationText ?? this.durationText,
      isFallbackRoute: isFallbackRoute ?? this.isFallbackRoute,
    );
  }

  @override
  List<Object?> get props => [
    storeLocation,
    userLocation,
    polyline,
    distanceText,
    durationText,
    isFallbackRoute,
  ];
}
