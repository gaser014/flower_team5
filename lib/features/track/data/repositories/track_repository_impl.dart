import 'dart:async';

import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/config/fcm/order_notification_service.dart';
import 'package:flowers_app/features/track/data/datasources/track_local_data_source_contract.dart';
import 'package:flowers_app/features/track/data/datasources/track_remote_data_source_contract.dart';
import 'package:flowers_app/features/track/domain/entities/track_order_entity.dart';
import 'package:flowers_app/features/track/domain/repositories/track_repository.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: TrackRepository)
class TrackRepositoryImpl implements TrackRepository {
  final TrackRemoteDataSourceContract _remoteDataSource;
  final TrackLocalDataSourceContract _localDataSource;
  final OrderNotificationService _orderNotificationService;

  TrackRepositoryImpl({
    required TrackRemoteDataSourceContract remoteDataSource,
    required TrackLocalDataSourceContract localDataSource,
    required OrderNotificationService orderNotificationService,
  }) : _remoteDataSource = remoteDataSource,
       _localDataSource = localDataSource,
       _orderNotificationService = orderNotificationService;

  @override
  Future<Result<TrackOrderEntity>> getOrder({required String orderId}) async {
    final result = await _remoteDataSource.getOrder(orderId: orderId);
    return result.when(
      success: (data) =>
          Success(data: data?.toEntity() ?? TrackOrderEntity.empty(orderId)),
      error: (exception) => Error(exception: exception),
    );
  }

  @override
  Stream<TrackOrderEntity> watchOrder({required String orderId}) {
    return _remoteDataSource
        .watchOrder(orderId: orderId)
        .map((model) => model.toEntity());
  }

  @override
  Stream<TrackOrderEntity> watchUserOrder({
    required String userId,
    required String orderId,
  }) {
    return _remoteDataSource
        .watchUserOrder(userId: userId, orderId: orderId)
        .map((model) => model.toEntity());
  }

  @override
  Future<Result<void>> markDelivered({required String orderId}) async {
    final result = await _remoteDataSource.markDelivered(orderId: orderId);
    // On success, push a notification to the assigned driver so their app can
    // react to the delivery confirmation live.
    result.when(
      success: (_) => unawaited(
        _orderNotificationService.notifyDriverOrderDelivered(orderId: orderId),
      ),
      error: (_) {},
    );
    return result;
  }

  @override
  Future<String?> getLastTrackedOrderId() =>
      _localDataSource.getLastTrackedOrderId();

  @override
  Future<void> saveLastTrackedOrderId(String orderId) =>
      _localDataSource.saveLastTrackedOrderId(orderId);
}
