import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flowers_app/config/fcm/fcm_service.dart';
import 'package:flowers_app/config/fcm/fcm_user_entity.dart';
import 'package:flowers_app/core/values/notification_keys.dart';
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
  static const String _notificationsCollection = 'notifications';
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

      // Always persist the notification (stores KEYS, not translated text).
      await _addNotification(
        recipientId: driverId,
        orderId: orderId,
        orderNumber: orderNumber,
      );

      final tokens = await _driverTokens(driverId);
      if (tokens.isEmpty) {
        log('No FCM tokens found for driver $driverId', name: _logName);
        return;
      }

      await FCMService().sendNotification(
        targetFcmTokens: tokens,
        // English fallback for the system tray; the driver app re-translates
        // from the keys in `data` when it handles the message.
        title: NotificationKeys.deliveredByCustomerTitle.tr(),
        body: NotificationKeys.deliveredByCustomer.tr(),
        data: {
          'type': 'order_status',
          'orderId': orderId,
          'orderNumber': orderNumber,
          'status': 'delivered',
          'titleKey': NotificationKeys.deliveredByCustomerTitle,
          'bodyKey': NotificationKeys.deliveredByCustomer,
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

  Future<void> _addNotification({
    required String recipientId,
    String orderId = '',
    String orderNumber = '',
  }) async {
    if (recipientId.isEmpty) return;
    await _firestore.collection(_notificationsCollection).add({
      'recipientId': recipientId,
      'recipientType': 'driver',
      'type': 'order_status',
      'orderId': orderId,
      'orderNumber': orderNumber,
      'status': 'delivered',
      'titleKey': NotificationKeys.deliveredByCustomerTitle,
      'bodyKey': NotificationKeys.deliveredByCustomer,
      'read': false,
      'createdAt': FieldValue.serverTimestamp(),
    });
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
