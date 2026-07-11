import 'package:flowers_app/features/track/domain/repositories/track_repository.dart';
import 'package:injectable/injectable.dart';

/// Persists the last order the customer tracked so the track tab can resume it.
@injectable
class SaveLastTrackedOrderUseCase {
  final TrackRepository _repository;

  SaveLastTrackedOrderUseCase(this._repository);

  Future<void> call(String orderId) =>
      _repository.saveLastTrackedOrderId(orderId);
}
