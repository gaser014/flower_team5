import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/config/error_handling/failures.dart';
import 'package:flowers_app/config/fcm/fcm_service.dart';
import 'package:flowers_app/core/values/app_strings.dart';
import 'package:flowers_app/features/track/data/datasources/track_remote_data_source_contract.dart';
import 'package:flowers_app/features/track/data/models/track_order_model.dart';
import 'package:flowers_app/features/track/domain/entities/track_order_entity.dart';
import 'package:injectable/injectable.dart';

/// Reads order tracking data from Firebase Firestore, driven entirely by FCM
/// push notifications — no persistent Firestore listeners are opened.
///
/// Both [watchOrder] and [watchUserOrder] work the same way:
///   1. Subscribe to [FCMService.orderStatusStream].
///   2. Filter pushes by [orderId].
///   3. On each matching push, do a single Firestore `get()` to retrieve the
///      full up-to-date document and emit it on the stream.
///
/// This keeps the app battery- and bandwidth-friendly: the Firestore connection
/// is opened only when there is actually something new to fetch.
@LazySingleton(as: TrackRemoteDataSourceContract)
class TrackRemoteDataSourceImpl implements TrackRemoteDataSourceContract {
  final FirebaseFirestore _firestore;
  final FCMService _fcmService;

  TrackRemoteDataSourceImpl({
    required FirebaseFirestore firestore,
    required FCMService fcmService,
  }) : _firestore = firestore,
       _fcmService = fcmService;

  static const String _ordersCollection = 'orders';
  static const String _usersCollection = 'users';
  static const String _logName = 'TrackRemoteDataSource';

  CollectionReference<Map<String, dynamic>> get _orders =>
      _firestore.collection(_ordersCollection);

  DocumentReference<Map<String, dynamic>> _userOrderDoc(
    String userId,
    String orderId,
  ) => _firestore
      .collection(_usersCollection)
      .doc(userId)
      .collection(_ordersCollection)
      .doc(orderId);

  @override
  Future<Result<TrackOrderModel>> getOrder({required String orderId}) async {
    if (orderId.isEmpty) {
      return Error(exception: Exception(AppStrings.somethingWentWrong));
    }
    try {
      final snapshot = await _orders.doc(orderId).get();
      final data = snapshot.data();
      if (data == null) {
        return Error(exception: Exception(AppStrings.somethingWentWrong));
      }
      return Success(data: TrackOrderModel.fromFirestore(orderId, data));
    } catch (e, s) {
      log('getOrder failed', name: _logName, error: e, stackTrace: s);
      return Error(exception: ServerFailure(errorMessage: e.toString()));
    }
  }

  @override
  Stream<TrackOrderModel> watchOrder({required String orderId}) {
    if (orderId.isEmpty) return const Stream.empty();

    final controller = StreamController<TrackOrderModel>.broadcast();

    final subscription = _fcmService.orderStatusStream
        .where((push) => push.orderId == orderId)
        .listen(
          (push) async {
            log(
              'FCM push → watchOrder: orderId=$orderId status=${push.status}',
              name: _logName,
            );
            try {
              final snapshot = await _orders.doc(orderId).get();
              final data = snapshot.data();
              if (data != null) {
                controller.add(TrackOrderModel.fromFirestore(orderId, data));
              } else {
                // Firestore doc not ready yet — emit a minimal model so the
                // UI can still reflect the new status immediately.
                controller.add(
                  TrackOrderModel.fromFirestore(orderId, {
                    'orderId': orderId,
                    'status': push.status,
                  }),
                );
              }
            } catch (e, s) {
              log(
                'watchOrder fetch failed for orderId=$orderId',
                name: _logName,
                error: e,
                stackTrace: s,
              );
            }
          },
          onError: (Object e, StackTrace s) {
            log(
              'watchOrder stream error',
              name: _logName,
              error: e,
              stackTrace: s,
            );
          },
        );

    controller.onCancel = () {
      subscription.cancel();
      controller.close();
    };

    return controller.stream;
  }

  /// Listens to FCM push notifications for status changes on [orderId].
  ///
  /// Each time the driver app pushes a `type: 'order_status'` notification for
  /// this order, we do a single Firestore read of `users/{userId}/orders/{orderId}`
  /// to get the full, up-to-date document and emit it on the stream.
  ///
  /// This avoids a persistent Firestore listener — updates are push-driven.
  @override
  Stream<TrackOrderModel> watchUserOrder({
    required String userId,
    required String orderId,
  }) {
    if (userId.isEmpty || orderId.isEmpty) return const Stream.empty();

    final controller = StreamController<TrackOrderModel>.broadcast();

    final subscription = _fcmService.orderStatusStream
        .where((push) => push.orderId == orderId)
        .listen(
          (push) async {
            log(
              'FCM order-status push received: orderId=$orderId status=${push.status}',
              name: _logName,
            );
            try {
              final snapshot = await _userOrderDoc(userId, orderId).get();
              final data = snapshot.data();
              if (data != null) {
                controller.add(TrackOrderModel.fromFirestore(orderId, data));
              } else {
                // Document not yet written — emit a minimal model with just
                // the status from the push so the UI can update immediately.
                controller.add(
                  TrackOrderModel.fromFirestore(orderId, {
                    'orderId': orderId,
                    'status': push.status,
                  }),
                );
              }
            } catch (e, s) {
              log(
                'watchUserOrder fetch failed for orderId=$orderId',
                name: _logName,
                error: e,
                stackTrace: s,
              );
            }
          },
          onError: (Object e, StackTrace s) {
            log(
              'watchUserOrder stream error',
              name: _logName,
              error: e,
              stackTrace: s,
            );
          },
        );

    controller.onCancel = () {
      subscription.cancel();
      controller.close();
    };

    return controller.stream;
  }

  @override
  Future<Result<void>> markDelivered({required String orderId}) async {
    if (orderId.isEmpty) {
      return Error(exception: Exception(AppStrings.somethingWentWrong));
    }
    try {
      await _orders.doc(orderId).set({
        'status': TrackOrderStatus.delivered.name,
        'deliveredByCustomer': true,
        'updatedAt': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
      return const Success(data: null);
    } catch (e, s) {
      log('markDelivered failed', name: _logName, error: e, stackTrace: s);
      return Error(exception: ServerFailure(errorMessage: e.toString()));
    }
  }
}
