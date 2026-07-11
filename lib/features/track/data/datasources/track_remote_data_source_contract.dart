import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/features/track/data/models/track_order_model.dart';

abstract interface class TrackRemoteDataSourceContract {
  /// One-time read of the Firebase order tracking document.
  Future<Result<TrackOrderModel>> getOrder({required String orderId});

  /// Live stream of the Firebase order tracking document (`orders/{orderId}`).
  Stream<TrackOrderModel> watchOrder({required String orderId});

  /// Live stream of the order mirrored onto the customer's user document
  /// (`users/{userId}/orders/{orderId}`). The driver app writes to this path
  /// via `OrderTrackingService.setUserOrder` on every status change, so this
  /// stream reflects push-notification-level updates for the logged-in user.
  Stream<TrackOrderModel> watchUserOrder({
    required String userId,
    required String orderId,
  });

  /// Marks the order as delivered. This is the customer's action only — the
  /// driver app can only advance the order up to "arrived".
  Future<Result<void>> markDelivered({required String orderId});
}
