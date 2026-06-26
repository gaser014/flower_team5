import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flowers_app/config/base_state/base_state.dart';
import 'package:flowers_app/features/track_order/domain/entities/track_order_entity.dart';
import 'package:flowers_app/features/track_order/domain/use_cases/watch_order_status_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

part 'track_order_events.dart';
part 'track_order_states.dart';

@injectable
class TrackOrderCubit extends Cubit<TrackOrderStates> {
  final WatchOrderStatusUseCase _watchOrderStatusUseCase;
  StreamSubscription<TrackOrderEntity?>? _subscription;

  TrackOrderCubit({required WatchOrderStatusUseCase watchOrderStatusUseCase})
    : _watchOrderStatusUseCase = watchOrderStatusUseCase,
      super(const TrackOrderStates());

  @override
  void emit(TrackOrderStates state) {
    if (!isClosed) super.emit(state);
  }

  Future<void> doIntent(TrackOrderEvents event) async => switch (event) {
    StartTrackingEvent() => _startTracking(event.orderId),
  };

  void _startTracking(String orderId) {
    emit(state.copyWith(trackState: const BaseState.loading()));
    _subscription?.cancel();
    _subscription = _watchOrderStatusUseCase.call(orderId).listen(
      (order) {
        if (order == null) {
          emit(state.copyWith(trackState: BaseState.error(_notFound())));
        } else {
          emit(state.copyWith(trackState: BaseState.success(order)));
        }
      },
      onError: (Object error) {
        emit(
          state.copyWith(
            trackState: BaseState.error(
              error is Exception ? error : Exception(error.toString()),
            ),
          ),
        );
      },
    );
  }

  Exception _notFound() => Exception('Order not found');

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
