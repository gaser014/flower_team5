import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/config/uses_cases/use_cases.dart';
import 'package:flowers_app/features/track/domain/repositories/track_repository.dart';
import 'package:injectable/injectable.dart';

/// Marks the customer's own order as delivered. This is the only place an order
/// can be moved to the "delivered" status — the driver app stops at "arrived".
@injectable
class MarkDeliveredUseCase extends UseCase<void, String> {
  final TrackRepository _repository;

  MarkDeliveredUseCase(this._repository);

  @override
  Future<Result<void>> call(String orderId) =>
      _repository.markDelivered(orderId: orderId);
}
