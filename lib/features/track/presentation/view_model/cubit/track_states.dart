part of 'track_cubit.dart';

class TrackStates extends Equatable {
  /// The tracked order. Updated automatically as Firebase emits new snapshots.
  final BaseState<TrackOrderEntity> orderState;

  /// The customer's "mark delivered" action state (loading/success/error).
  final BaseState<void> deliverState;

  const TrackStates({
    this.orderState = const BaseState.initial(),
    this.deliverState = const BaseState.initial(),
  });

  TrackStates copyWith({
    BaseState<TrackOrderEntity>? orderState,
    BaseState<void>? deliverState,
  }) {
    return TrackStates(
      orderState: orderState ?? this.orderState,
      deliverState: deliverState ?? this.deliverState,
    );
  }

  @override
  List<Object?> get props => [orderState, deliverState];
}
