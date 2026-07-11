import 'dart:developer';

import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/features/order_tracking/api/directions_api_client.dart';
import 'package:flowers_app/features/order_tracking/data/datasources/order_tracking_remote_data_source_contract.dart';
import 'package:flowers_app/features/order_tracking/domain/entities/lat_lng_entity.dart';
import 'package:flowers_app/features/order_tracking/domain/entities/order_route_entity.dart';
import 'package:flowers_app/features/order_tracking/domain/entities/order_tracking_args.dart';
import 'package:flowers_app/features/order_tracking/domain/entities/tracking_order_entity.dart';
import 'package:flowers_app/features/order_tracking/domain/repositories/order_tracking_repository.dart';
import 'package:flowers_app/features/order_tracking/domain/tracking_defaults.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: OrderTrackingRepository)
class OrderTrackingRepositoryImpl implements OrderTrackingRepository {
  final OrderTrackingRemoteDataSourceContract _remoteDataSource;
  final DirectionsApiClient _directionsApiClient;

  OrderTrackingRepositoryImpl(
    this._remoteDataSource,
    this._directionsApiClient,
  );

  static const String _logName = 'OrderTrackingRepository';

  @override
  Stream<TrackingOrderEntity> watchOrder(OrderTrackingArgs args) =>
      _remoteDataSource.watchOrder(args);

  @override
  Future<Result<OrderRouteEntity>> getRoute({
    required LatLngEntity store,
    required LatLngEntity user,
  }) async {
    final directions = await _fetchDirections(store, user);

    if (directions != null && directions.points.isNotEmpty) {
      return Success(
        data: OrderRouteEntity(
          storeLocation: store,
          userLocation: user,
          polyline: directions.points,
          distanceText: directions.distanceText,
          durationText: directions.durationText,
        ),
      );
    }

    final meters = LatLngEntity.distanceMeters(store, user);
    return Success(
      data: OrderRouteEntity(
        storeLocation: store,
        userLocation: user,
        polyline: [store, user],
        distanceText: _distanceText(meters),
        durationText: _roughDurationText(meters),
        isFallbackRoute: true,
      ),
    );
  }

  Future<_DirectionsData?> _fetchDirections(
    LatLngEntity origin,
    LatLngEntity destination,
  ) async {
    try {
      final result = await _directionsApiClient.getRoute(
        origin: origin,
        destination: destination,
      );
      return _DirectionsData(
        result.points,
        result.distanceText,
        result.durationText,
      );
    } catch (e) {
      log('directions request failed: $e', name: _logName);
      return null;
    }
  }

  String _distanceText(double meters) {
    if (meters < 1000) return '${meters.round()} m';
    return '${(meters / 1000).toStringAsFixed(1)} km';
  }

  String _roughDurationText(double meters) {
    final km = meters / 1000;
    final minutes = (km / TrackingDefaults.averageSpeedKmh * 60).round();
    final clamped = minutes < 1 ? 1 : minutes;
    return '~$clamped min';
  }
}

class _DirectionsData {
  final List<LatLngEntity> points;
  final String distanceText;
  final String durationText;

  const _DirectionsData(this.points, this.distanceText, this.durationText);
}
