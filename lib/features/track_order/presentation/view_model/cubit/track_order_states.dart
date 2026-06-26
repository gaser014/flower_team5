part of 'track_order_cubit.dart';

class TrackOrderStates extends Equatable {
  final BaseState<TrackOrderEntity> trackState;

  const TrackOrderStates({this.trackState = const BaseState.initial()});

  TrackOrderStates copyWith({BaseState<TrackOrderEntity>? trackState}) {
    return TrackOrderStates(trackState: trackState ?? this.trackState);
  }

  @override
  List<Object?> get props => [trackState];
}
