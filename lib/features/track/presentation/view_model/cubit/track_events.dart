part of 'track_cubit.dart';

sealed class TrackEvents {
  const TrackEvents();
}

/// Start tracking a specific order: fetch once, then listen for live updates.
class StartTrackingEvent extends TrackEvents {
  final String orderId;

  const StartTrackingEvent({required this.orderId});
}

/// Resume tracking the last order the customer viewed (used by the track tab).
class ResumeTrackingEvent extends TrackEvents {
  const ResumeTrackingEvent();
}

/// Emitted internally whenever a fresh order snapshot arrives from Firebase.
class OrderUpdatedEvent extends TrackEvents {
  final TrackOrderEntity order;

  const OrderUpdatedEvent(this.order);
}

/// Emitted internally when the live order stream errors.
class TrackErrorEvent extends TrackEvents {
  final Exception exception;

  const TrackErrorEvent(this.exception);
}

/// Customer confirms they received the order, moving it to "delivered".
class MarkDeliveredEvent extends TrackEvents {
  const MarkDeliveredEvent();
}

/// Stop listening to the live order stream.
class StopTrackingEvent extends TrackEvents {
  const StopTrackingEvent();
}
