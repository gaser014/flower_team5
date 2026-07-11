part of 'order_tracking_cubit.dart';

sealed class OrderTrackingEvents {
  const OrderTrackingEvents();
}

final class WatchOrderEvent extends OrderTrackingEvents {
  final OrderTrackingArgs args;

  const WatchOrderEvent(this.args);
}

final class OrderUpdatedEvent extends OrderTrackingEvents {
  final TrackingOrderEntity order;

  const OrderUpdatedEvent(this.order);
}
