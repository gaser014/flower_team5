import 'package:flowers_app/features/track/domain/entities/track_order_entity.dart';
import 'package:flowers_app/features/track/domain/repositories/track_repository.dart';
import 'package:injectable/injectable.dart';

/// Streams live order updates (status + driver location) from Firebase so the
/// cubit can auto-refresh the UI without polling.
@injectable
class WatchOrderUseCase {
  final TrackRepository _repository;

  WatchOrderUseCase(this._repository);

  Stream<TrackOrderEntity> call(String orderId) =>
      _repository.watchOrder(orderId: orderId);
}
