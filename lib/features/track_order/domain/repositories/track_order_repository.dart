import 'package:flowers_app/features/track_order/domain/entities/track_order_entity.dart';

abstract class TrackOrderRepository {
  Stream<TrackOrderEntity?> watchOrder(String orderId);
}
