import 'package:flowers_app/features/order_tracking/domain/entities/order_tracking_args.dart';
import 'package:flowers_app/features/order_tracking/domain/entities/tracking_order_entity.dart';

abstract interface class OrderTrackingRemoteDataSourceContract {
  Stream<TrackingOrderEntity> watchOrder(OrderTrackingArgs args);
}
