import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/features/order_tracking/domain/entities/lat_lng_entity.dart';
import 'package:flowers_app/features/order_tracking/domain/entities/order_route_entity.dart';
import 'package:flowers_app/features/order_tracking/domain/entities/order_tracking_args.dart';
import 'package:flowers_app/features/order_tracking/domain/entities/tracking_order_entity.dart';

abstract interface class OrderTrackingRepository {
  Stream<TrackingOrderEntity> watchOrder(OrderTrackingArgs args);
  Future<Result<OrderRouteEntity>> getRoute({
    required LatLngEntity store,
    required LatLngEntity user,
  });
}
