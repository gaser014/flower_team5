import 'package:flowers_app/features/order_tracking/domain/entities/order_tracking_args.dart';
import 'package:flowers_app/features/order_tracking/domain/entities/tracking_order_entity.dart';
import 'package:flowers_app/features/order_tracking/domain/repositories/order_tracking_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class WatchOrderTrackingUseCase {
  final OrderTrackingRepository _repository;

  WatchOrderTrackingUseCase(this._repository);

  Stream<TrackingOrderEntity> call(OrderTrackingArgs args) =>
      _repository.watchOrder(args);
}
