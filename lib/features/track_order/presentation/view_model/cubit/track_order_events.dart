part of 'track_order_cubit.dart';

sealed class TrackOrderEvents {
  const TrackOrderEvents();
}

class StartTrackingEvent extends TrackOrderEvents {
  final String orderId;

  const StartTrackingEvent(this.orderId);
}
