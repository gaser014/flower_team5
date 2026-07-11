import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flowers_app/config/base_state/base_state.dart';
import 'package:flowers_app/core/values/app_strings.dart';
import 'package:flowers_app/features/track/domain/entities/track_order_entity.dart';
import 'package:flowers_app/features/track/domain/use_cases/mark_delivered_use_case.dart';
import 'package:flowers_app/features/track/domain/use_cases/get_last_tracked_order_use_case.dart';
import 'package:flowers_app/features/track/domain/use_cases/get_order_use_case.dart';
import 'package:flowers_app/features/track/domain/use_cases/save_last_tracked_order_use_case.dart';
import 'package:flowers_app/features/track/domain/use_cases/watch_order_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'track_events.dart';
part 'track_states.dart';

/// Drives the customer order-tracking screens.
///
/// [StartTrackingEvent] does one initial fetch of the order by id, then
/// subscribes to the Firebase document stream so every driver-side status or
/// location change automatically flows into [TrackStates.orderState] — no
/// polling and no manual refresh needed.
@injectable
class TrackCubit extends Cubit<TrackStates> with WidgetsBindingObserver {
  final GetOrderUseCase _getOrderUseCase;
  final WatchOrderUseCase _watchOrderUseCase;
  final MarkDeliveredUseCase _markDeliveredUseCase;
  final SaveLastTrackedOrderUseCase _saveLastTrackedOrderUseCase;
  final GetLastTrackedOrderUseCase _getLastTrackedOrderUseCase;

  TrackCubit({
    required GetOrderUseCase getOrderUseCase,
    required WatchOrderUseCase watchOrderUseCase,
    required MarkDeliveredUseCase markDeliveredUseCase,
    required SaveLastTrackedOrderUseCase saveLastTrackedOrderUseCase,
    required GetLastTrackedOrderUseCase getLastTrackedOrderUseCase,
  }) : _getOrderUseCase = getOrderUseCase,
       _watchOrderUseCase = watchOrderUseCase,
       _markDeliveredUseCase = markDeliveredUseCase,
       _saveLastTrackedOrderUseCase = saveLastTrackedOrderUseCase,
       _getLastTrackedOrderUseCase = getLastTrackedOrderUseCase,
       super(const TrackStates()) {
    // FCM `onMessage` only fires in the foreground, so a status change that
    // arrived while the app was backgrounded would be missed. Re-fetch the
    // order whenever the app resumes to reconcile any missed pushes.
    WidgetsBinding.instance.addObserver(this);
  }

  StreamSubscription<TrackOrderEntity>? _orderSub;
  String? _orderId;

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) _refreshOrder();
  }

  /// Silent re-fetch (no loading state) used to reconcile missed FCM pushes.
  Future<void> _refreshOrder() async {
    final orderId = _orderId;
    if (orderId == null || orderId.isEmpty) return;
    final result = await _getOrderUseCase(orderId);
    result.when(
      success: (data) {
        if (data != null) {
          emit(state.copyWith(orderState: BaseState.success(data)));
        }
      },
      error: (_) {},
    );
  }

  @override
  void emit(TrackStates state) {
    if (!isClosed) super.emit(state);
  }

  Future<void> doIntent(TrackEvents event) async => switch (event) {
    StartTrackingEvent() => _startTracking(event),
    ResumeTrackingEvent() => _resumeTracking(event),
    OrderUpdatedEvent() => _onOrderUpdated(event),
    TrackErrorEvent() => _onTrackError(event),
    MarkDeliveredEvent() => _markDelivered(),
    StopTrackingEvent() => _stopTracking(),
  };

  Future<void> _startTracking(StartTrackingEvent event) async {
    final orderId = event.orderId.trim();
    if (orderId.isEmpty) {
      emit(
        state.copyWith(
          orderState: BaseState.error(Exception(AppStrings.somethingWentWrong)),
        ),
      );
      return;
    }

    _orderId = orderId;
    emit(state.copyWith(orderState: const BaseState.loading()));

    // 1. One-time fetch so the screen renders immediately.
    final result = await _getOrderUseCase(orderId);
    result.when(
      success: (data) {
        if (data != null) {
          emit(state.copyWith(orderState: BaseState.success(data)));
        }
      },
      error: (exception) => emit(
        state.copyWith(
          orderState: BaseState.error(
            exception ?? Exception(AppStrings.somethingWentWrong),
          ),
        ),
      ),
    );

    // 2. Remember it and subscribe for automatic live updates.
    unawaited(_saveLastTrackedOrderUseCase(orderId));
    _listenToOrder(orderId);
  }

  Future<void> _resumeTracking(ResumeTrackingEvent event) async {
    final orderId = await _getLastTrackedOrderUseCase();
    if (orderId == null || orderId.isEmpty) {
      emit(
        state.copyWith(
          orderState: BaseState.error(Exception(AppStrings.noTrackedOrder)),
        ),
      );
      return;
    }
    await _startTracking(StartTrackingEvent(orderId: orderId));
  }

  void _listenToOrder(String orderId) {
    _orderSub?.cancel();
    _orderSub = _watchOrderUseCase(orderId).listen(
      (order) => doIntent(OrderUpdatedEvent(order)),
      onError: (Object error) => doIntent(
        TrackErrorEvent(
          error is Exception ? error : Exception(error.toString()),
        ),
      ),
    );
  }

  void _onOrderUpdated(OrderUpdatedEvent event) {
    final incoming = event.order;
    // Ignore stale updates from a previous order id.
    if (_orderId != null && incoming.id.isNotEmpty && incoming.id != _orderId) {
      return;
    }

    // The push carries only the new status. Merge it onto the already-loaded
    // order so we keep the driver, store, items, etc. instead of wiping them.
    final current = state.orderState.data;
    final merged = current == null
        ? incoming
        : current.copyWith(status: incoming.status);
    emit(state.copyWith(orderState: BaseState.success(merged)));
  }

  void _onTrackError(TrackErrorEvent event) {
    // Only surface a stream error when we have nothing to show yet; otherwise
    // keep the last known order visible.
    if (state.orderState.isSuccess) return;
    emit(state.copyWith(orderState: BaseState.error(event.exception)));
  }

  /// Customer-only action: mark the currently tracked order as delivered once
  /// the driver has arrived. On success the live Firebase stream emits the
  /// `delivered` snapshot, which updates [TrackStates.orderState] automatically.
  Future<void> _markDelivered() async {
    final orderId = _orderId;
    if (orderId == null || orderId.isEmpty) return;
    if (state.deliverState.isLoading) return;

    // Guard: the customer can only confirm delivery after the driver arrived.
    final order = state.orderState.data;
    if (order != null && order.status != TrackOrderStatus.arrived) return;

    emit(state.copyWith(deliverState: const BaseState.loading()));

    final result = await _markDeliveredUseCase(orderId);
    result.when(
      success: (_) {
        // No FCM push is sent to the customer for their OWN action, so update
        // the tracked order locally right away instead of waiting for a push.
        final current = state.orderState.data;
        emit(
          state.copyWith(
            deliverState: const BaseState.success(null),
            orderState: current != null
                ? BaseState.success(
                    current.copyWith(status: TrackOrderStatus.delivered),
                  )
                : null,
          ),
        );
      },
      error: (exception) => emit(
        state.copyWith(
          deliverState: BaseState.error(
            exception ?? Exception(AppStrings.somethingWentWrong),
          ),
        ),
      ),
    );
  }

  Future<void> _stopTracking() async {
    await _orderSub?.cancel();
    _orderSub = null;
  }

  @override
  Future<void> close() {
    WidgetsBinding.instance.removeObserver(this);
    _orderSub?.cancel();
    return super.close();
  }
}
