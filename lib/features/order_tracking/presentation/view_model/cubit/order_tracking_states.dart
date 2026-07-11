part of 'order_tracking_cubit.dart';

class OrderTrackingStates extends Equatable {
  /// The order as watched from Firebase. Loading while the first snapshot
  /// arrives.
  final BaseState<TrackingOrderEntity> orderState;

  /// The resolved store → customer route (fetched once). Null until ready.
  final OrderRouteEntity? route;

  /// The driver's latest live position from Firebase (drives the moving
  /// marker). Kept separate so location updates never re-trigger a route fetch.
  final LatLngEntity? driverLocation;

  /// True once the driver reaches the customer. When set, live tracking is
  /// stopped and the UI shows the arrival state.
  final bool hasArrived;

  const OrderTrackingStates({
    this.orderState = const BaseState.initial(),
    this.route,
    this.driverLocation,
    this.hasArrived = false,
  });

  OrderTrackingStates copyWith({
    BaseState<TrackingOrderEntity>? orderState,
    OrderRouteEntity? route,
    LatLngEntity? driverLocation,
    bool? hasArrived,
  }) {
    return OrderTrackingStates(
      orderState: orderState ?? this.orderState,
      route: route ?? this.route,
      driverLocation: driverLocation ?? this.driverLocation,
      hasArrived: hasArrived ?? this.hasArrived,
    );
  }

  @override
  List<Object?> get props => [orderState, route, driverLocation, hasArrived];
}
