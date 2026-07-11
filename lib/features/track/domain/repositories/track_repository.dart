import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/features/track/domain/entities/track_order_entity.dart';

abstract interface class TrackRepository {
  /// One-time fetch of the order tracking document by [orderId].
  Future<Result<TrackOrderEntity>> getOrder({required String orderId});

  /// Live stream of the order tracking document (`orders/{orderId}`). Emits a
  /// fresh [TrackOrderEntity] every time the driver app updates the order
  /// status or the driver's location on Firebase.
  Stream<TrackOrderEntity> watchOrder({required String orderId});

  /// Live stream of the order mirrored onto the customer's user document
  /// (`users/{userId}/orders/{orderId}`). The driver app writes to this path
  /// on every status change, making it the authoritative source for order
  /// status notifications for the logged-in user.
  Stream<TrackOrderEntity> watchUserOrder({
    required String userId,
    required String orderId,
  });

  /// Marks the order as delivered. Only the customer can do this for their own
  /// order; the driver app can advance it only up to "arrived".
  Future<Result<void>> markDelivered({required String orderId});

  /// The id of the last order the customer tracked (used to resume tracking).
  Future<String?> getLastTrackedOrderId();

  /// Persists [orderId] as the last order the customer tracked.
  Future<void> saveLastTrackedOrderId(String orderId);
}
