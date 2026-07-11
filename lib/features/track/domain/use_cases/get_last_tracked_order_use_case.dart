import 'package:flowers_app/features/track/domain/repositories/track_repository.dart';
import 'package:injectable/injectable.dart';

/// Reads the id of the last order the customer tracked, if any.
@injectable
class GetLastTrackedOrderUseCase {
  final TrackRepository _repository;

  GetLastTrackedOrderUseCase(this._repository);

  Future<String?> call() => _repository.getLastTrackedOrderId();
}
