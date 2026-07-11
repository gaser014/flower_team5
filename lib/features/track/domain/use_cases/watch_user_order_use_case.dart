import 'package:flowers_app/features/track/domain/entities/track_order_entity.dart';
import 'package:flowers_app/features/track/domain/repositories/track_repository.dart';
import 'package:injectable/injectable.dart';

/// Streams order status updates from the customer's user document
/// (`users/{userId}/orders/{orderId}`).
///
/// The driver app writes to this path on every status change via
/// `OrderTrackingService.setUserOrder`, so this stream is the authoritative
/// source for push-notification-level status updates for the logged-in user.
@injectable
class WatchUserOrderUseCase {
  final TrackRepository _repository;

  WatchUserOrderUseCase(this._repository);

  Stream<TrackOrderEntity> call({
    required String userId,
    required String orderId,
  }) => _repository.watchUserOrder(userId: userId, orderId: orderId);
}
