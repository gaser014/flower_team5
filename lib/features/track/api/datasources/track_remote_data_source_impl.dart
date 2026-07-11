import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flowers_app/config/base_response/result.dart';
import 'package:flowers_app/config/error_handling/failures.dart';
import 'package:flowers_app/core/values/app_strings.dart';
import 'package:flowers_app/features/track/data/datasources/track_remote_data_source_contract.dart';
import 'package:flowers_app/features/track/data/models/track_order_model.dart';
import 'package:flowers_app/features/track/domain/entities/track_order_entity.dart';
import 'package:injectable/injectable.dart';

/// Reads the order tracking document from Firebase Firestore. The driver app
/// (track_flowers_app) keeps `orders/{orderId}` up to date with the latest
/// status and driver location; this data source exposes it to the customer app.
@LazySingleton(as: TrackRemoteDataSourceContract)
class TrackRemoteDataSourceImpl implements TrackRemoteDataSourceContract {
  final FirebaseFirestore _firestore;

  TrackRemoteDataSourceImpl({required FirebaseFirestore firestore})
    : _firestore = firestore;

  static const String _ordersCollection = 'orders';
  static const String _usersCollection = 'users';
  static const String _logName = 'TrackRemoteDataSource';

  CollectionReference<Map<String, dynamic>> get _orders =>
      _firestore.collection(_ordersCollection);

  /// `users/{userId}/orders` — the subcollection the driver app writes to via
  /// `OrderTrackingService.setUserOrder` on every status change.
  CollectionReference<Map<String, dynamic>> _userOrders(String userId) =>
      _firestore
          .collection(_usersCollection)
          .doc(userId)
          .collection(_ordersCollection);

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
    return _orders
        .doc(orderId)
        .snapshots()
        .where((snapshot) => snapshot.data() != null)
        .map(
          (snapshot) =>
              TrackOrderModel.fromFirestore(orderId, snapshot.data()!),
        );
  }

  @override
  Stream<TrackOrderModel> watchUserOrder({
    required String userId,
    required String orderId,
  }) {
    if (userId.isEmpty || orderId.isEmpty) return const Stream.empty();
    return _userOrders(userId)
        .doc(orderId)
        .snapshots()
        .where((snapshot) => snapshot.data() != null)
        .map(
          (snapshot) =>
              TrackOrderModel.fromFirestore(orderId, snapshot.data()!),
        );
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
