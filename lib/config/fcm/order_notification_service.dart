import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flowers_app/config/fcm/fcm_service.dart';
import 'package:flowers_app/config/fcm/fcm_user_entity.dart';
import 'package:flowers_app/core/values/app_strings.dart';
import 'package:injectable/injectable.dart';

/// Sends order-status push notifications from the customer app to the driver.
///
/// The driver registers its FCM tokens under `users/{driverId}` (same shape the
/// driver app uses to notify customers), so we resolve the driver id from the
/// order document, read their tokens, and push through [FCMService].
@lazySingleton
class OrderNotificationService {
  final FirebaseFirestore _firestore;

  OrderNotificationService(this._firestore);

  static const String _ordersCollection = 'orders';
  static const String _usersCollection = 'users';
  static const String _logName = 'OrderNotificationService';

  /// Notify the driver assigned to [orderId] that the customer confirmed
  /// delivery, so the driver app can update the order status live.
  Future<void> notifyDriverOrderDelivered({
    required String orderId,
    String orderNumber = '',
  }) async {
    if (orderId.isEmpty) return;
    try {
      final driverId = await _resolveDriverId(orderId);
      if (driverId == null || driverId.isEmpty) {
        log('No driver id found for order $orderId', name: _logName);
        return;
      }

      final tokens = await _driverTokens(driverId);
      if (tokens.isEmpty) {
        log('No FCM tokens found for driver $driverId', name: _logName);
        return;
      }

      final label = orderNumber.isNotEmpty ? ' #$orderNumber' : '';
      await FCMService().sendNotification(
        targetFcmTokens: tokens,
        title: AppStrings.orderDeliveredTitle,
        body: '${AppStrings.orderDeliveredByCustomerBody}$label',
        data: {
          'type': 'order_status',
          'orderId': orderId,
          'status': 'delivered',
        },
      );
    } catch (e, s) {
      log(
        'notifyDriverOrderDelivered failed',
        name: _logName,
        error: e,
        stackTrace: s,
      );
    }
  }

  Future<String?> _resolveDriverId(String orderId) async {
    final snapshot = await _firestore
        .collection(_ordersCollection)
        .doc(orderId)
        .get();
    final data = snapshot.data();
    if (data == null) return null;
    final driver = data['driver'];
    if (driver is Map && driver['id'] != null) {
      return driver['id'].toString();
    }
    return data['driverId']?.toString();
  }

  Future<List<FCMTokenEntity>> _driverTokens(String driverId) async {
    final snapshot = await _firestore
        .collection(_usersCollection)
        .doc(driverId)
        .get();
    final data = snapshot.data();
    if (data == null) return const [];
    return _parseFcmTokens(data);
  }

  List<FCMTokenEntity> _parseFcmTokens(Map<String, dynamic> data) {
    final raw = data['fcmTokens'] ?? data['fcmToken'];
    final tokens = <FCMTokenEntity>[];

    void addToken(String token, [String lang = 'en']) {
      if (token.isEmpty) return;
      tokens.add(FCMTokenEntity(token: token, lang: lang));
    }

    if (raw is List) {
      for (final item in raw) {
        if (item is Map) {
          addToken(
            (item['token'] ?? '').toString(),
            (item['lang'] ?? 'en').toString(),
          );
        } else if (item is String) {
          addToken(item);
        }
      }
    } else if (raw is Map) {
      addToken(
        (raw['token'] ?? '').toString(),
        (raw['lang'] ?? 'en').toString(),
      );
    } else if (raw is String) {
      addToken(raw);
    }

    return tokens;
  }
}
