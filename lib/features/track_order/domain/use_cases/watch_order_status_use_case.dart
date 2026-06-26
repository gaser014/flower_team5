import 'package:flowers_app/features/track_order/domain/entities/track_order_entity.dart';
import 'package:flowers_app/features/track_order/domain/repositories/track_order_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class WatchOrderStatusUseCase {
  final TrackOrderRepository _repository;

  const WatchOrderStatusUseCase(this._repository);

  Stream<TrackOrderEntity?> call(String orderId) =>
      _repository.watchOrder(orderId);
}
