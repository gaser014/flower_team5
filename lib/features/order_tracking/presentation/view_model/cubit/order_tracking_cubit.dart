import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flowers_app/config/base_state/base_state.dart';
import 'package:flowers_app/features/order_tracking/domain/entities/lat_lng_entity.dart';
import 'package:flowers_app/features/order_tracking/domain/entities/order_route_entity.dart';
import 'package:flowers_app/features/order_tracking/domain/entities/order_tracking_args.dart';
import 'package:flowers_app/features/order_tracking/domain/entities/tracking_order_entity.dart';
import 'package:flowers_app/features/order_tracking/domain/tracking_defaults.dart';
import 'package:flowers_app/features/order_tracking/domain/use_cases/get_order_route_use_case.dart';
import 'package:flowers_app/features/order_tracking/domain/use_cases/watch_order_tracking_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'order_tracking_events.dart';
part 'order_tracking_states.dart';

@injectable
class OrderTrackingCubit extends Cubit<OrderTrackingStates> {
  final WatchOrderTrackingUseCase _watchOrderTrackingUseCase;
  final GetOrderRouteUseCase _getOrderRouteUseCase;

  OrderTrackingCubit(
    this._watchOrderTrackingUseCase,
    this._getOrderRouteUseCase,
  ) : super(const OrderTrackingStates());

  StreamSubscription<TrackingOrderEntity>? _orderSub;
  bool _routeRequested = false;
  bool _arrivalHandled = false;

  /// How close (meters) the driver must get to the customer before we treat
  /// the order as "arrived", stop tracking, and show the arrival state.
  static const double _arrivalThresholdMeters = 80;

  @override
  void emit(OrderTrackingStates state) {
    if (!isClosed) super.emit(state);
  }

  Future<void> doIntent(OrderTrackingEvents event) async {
    switch (event) {
      case WatchOrderEvent():
        _watchOrder(event);
      case OrderUpdatedEvent():
        await _onOrderUpdated(event);
    }
  }

  void _watchOrder(WatchOrderEvent event) {
    if (event.args.isEmpty) {
      emit(state.copyWith(orderState: BaseState.error(Exception('No order'))));
      return;
    }
    emit(state.copyWith(orderState: const BaseState.loading()));
    _orderSub?.cancel();
    _orderSub = _watchOrderTrackingUseCase(event.args).listen(
      (order) => doIntent(OrderUpdatedEvent(order)),
      onError: (Object error) => emit(
        state.copyWith(
          orderState: BaseState.error(
            error is Exception ? error : Exception('$error'),
          ),
        ),
      ),
    );
  }

  Future<void> _onOrderUpdated(OrderUpdatedEvent event) async {
    final order = event.order;
    final arrived = _arrivalHandled || _isDriverAtCustomer(order);
    emit(
      state.copyWith(
        orderState: BaseState.success(order),
        driverLocation: order.driverLocation,
        hasArrived: arrived,
      ),
    );
    await _loadRouteIfNeeded(order);

    // Driver reached the customer: stop listening to Firebase (stop tracking).
    if (arrived && !_arrivalHandled) {
      _arrivalHandled = true;
      _orderSub?.cancel();
    }
  }

  /// Whether the driver's live position is within the arrival radius of the
  /// customer's location.
  bool _isDriverAtCustomer(TrackingOrderEntity order) {
    final driver = order.driverLocation;
    final user = order.userLocation;
    if (driver == null || user == null) return false;
    return LatLngEntity.distanceMeters(driver, user) <= _arrivalThresholdMeters;
  }

  Future<void> _loadRouteIfNeeded(TrackingOrderEntity order) async {
    if (_routeRequested) return;
    final store = order.storeLocation ?? TrackingDefaults.storeLocation;
    final user = order.userLocation;
    if (user == null) return;

    _routeRequested = true;
    final result = await _getOrderRouteUseCase(
      GetOrderRouteParams(store: store, user: user),
    );
    result.when(
      success: (route) {
        if (route != null) emit(state.copyWith(route: route));
      },
      error: (_) => _routeRequested = false,
    );
  }

  @override
  Future<void> close() {
    _orderSub?.cancel();
    return super.close();
  }
}
