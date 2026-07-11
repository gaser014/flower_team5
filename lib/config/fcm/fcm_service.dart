import 'dart:convert';
import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flowers_app/config/fcm/fcm_user_entity.dart';
import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:googleapis_auth/auth_io.dart';

bool isFCMInitialized = false;

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {}

class FCMService {
  static final FCMService _instance = FCMService._internal();
  factory FCMService() => _instance;
  FCMService._internal();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  String? _fcmToken;
  String? get fcmToken => _fcmToken;

  /// Initialize FCM and set up all notification handlers
  Future<void> initialize() async {
    if (isFCMInitialized) return;
    // Request notification permissions (iOS and Android 13+)
    NotificationSettings settings = await _firebaseMessaging
        .requestPermission();

    log('User granted permission: ${settings.authorizationStatus}');

    // Initialize local notifications for foreground handling
    await _initializeLocalNotifications();

    // Get and store FCM token (unique device identifier)
    _fcmToken = await _firebaseMessaging.getToken();
    log('FCM Token: $_fcmToken');
    // Send this token to your backend server to send notifications

    // Listen for token refresh (happens when app reinstalled, data cleared, etc.)
    _firebaseMessaging.onTokenRefresh.listen((newToken) {
      _fcmToken = newToken;
      log('FCM Token refreshed: $newToken');
      // Update token on your server
    });

    // Set up background message handler
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    // Handle notification when app is in FOREGROUND
    FirebaseMessaging.onMessage.listen(_handleForegroundMessage);

    // Handle notification tap when app is in BACKGROUND (not terminated)
    FirebaseMessaging.onMessageOpenedApp.listen(_handleNotificationTap);

    // Check if app was opened from a TERMINATED state by tapping notification
    RemoteMessage? initialMessage = await _firebaseMessaging
        .getInitialMessage();

    if (initialMessage != null) {
      _handleNotificationTap(initialMessage);
    }

    isFCMInitialized = true;
  }

  /// Initialize local notifications plugin
  Future<void> _initializeLocalNotifications() async {
    // Android notification icon (place in android/app/src/main/res/drawable/)
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    // iOS notification settings
    const DarwinInitializationSettings iosSettings =
        DarwinInitializationSettings();

    const InitializationSettings initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    // Initialize with callback for when notification is tapped
    await _localNotifications.initialize(settings: initSettings);

    // Create notification channel for Android
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'high_importance_channel', // Must match AndroidManifest
      'High Importance Notifications',
      description: 'This channel is used for important notifications',
      importance: Importance.high, // Shows as heads-up notification
      playSound: true,
      enableVibration: true,
    );

    await _localNotifications
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(channel);
  }

  /// Handle messages when app is in FOREGROUND
  void _handleForegroundMessage(RemoteMessage message) {
    showLocalNotification(message);
  }

  /// Display local notification
  Future<void> showLocalNotification(RemoteMessage message) async {
    RemoteNotification? notification = message.notification;
    // AndroidNotification? android = message.notification?.android;
    const AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(
          'high_importance_channel',
          'High Importance Notifications',
          channelDescription:
              'This channel is used for important notifications',
          importance: Importance.max,
          priority: Priority.high,
          color: AppColors.primerColor,
          playSound: true,
          enableVibration: true,
        );

    const DarwinNotificationDetails darwinNotificationDetails =
        DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        );

    const NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
      iOS: darwinNotificationDetails,
    );
    if (notification != null) {
      await _localNotifications.show(
        id: notification.hashCode, // Unique notification ID
        title: notification.title,
        body: notification.body,
        notificationDetails: notificationDetails,
        payload: message.data.toString(), // Pass data for tap handling
      );
    }
  }

  /// Handle notification tap (from background or terminated state)
  void _handleNotificationTap(RemoteMessage message) {
    log('Notification tapped!');
    log('Message data: ${message.data}');

    if (message.data['screen'] != null) {}
  }

  /// Send a push notification directly from the client to multiple FCM tokens
  /// using the FCM HTTP v1 API and a Service Account loaded from `.env`.
  /// ⚠️ For production this logic belongs on your backend.
  Future<void> sendNotification({
    required List<FCMTokenEntity> targetFcmTokens,
    required String title,
    required String body,
    Map<String, String> data = const {},
  }) async {
    if (targetFcmTokens.isEmpty) {
      log('sendNotification: no target tokens');
      return;
    }
    try {
      final String projectId = dotenv.env['FCM_PROJECT_ID'] ?? '';
      final String privateKeyId = dotenv.env['FCM_PRIVATE_KEY_ID'] ?? '';
      final String privateKey = (dotenv.env['FCM_PRIVATE_KEY'] ?? '')
          .replaceAll('\\n', '\n');
      final String clientEmail = dotenv.env['FCM_CLIENT_EMAIL'] ?? '';
      final String clientId = dotenv.env['FCM_CLIENT_ID'] ?? '';
      final String clientX509CertUrl =
          dotenv.env['FCM_CLIENT_X509_CERT_URL'] ?? '';

      if (projectId.isEmpty || privateKey.isEmpty || clientEmail.isEmpty) {
        log('sendNotification: missing FCM service account env values');
        return;
      }

      final String serviceAccountJsonString = jsonEncode({
        "type": "service_account",
        "project_id": projectId,
        "private_key_id": privateKeyId,
        "private_key": privateKey,
        "client_email": clientEmail,
        "client_id": clientId,
        "auth_uri": "https://accounts.google.com/o/oauth2/auth",
        "token_uri": "https://oauth2.googleapis.com/token",
        "auth_provider_x509_cert_url":
            "https://www.googleapis.com/oauth2/v1/certs",
        "client_x509_cert_url": clientX509CertUrl,
        "universe_domain": "googleapis.com",
      });

      final accountCredentials = ServiceAccountCredentials.fromJson(
        serviceAccountJsonString,
      );
      final scopes = ['https://www.googleapis.com/auth/firebase.messaging'];
      final client = await clientViaServiceAccount(accountCredentials, scopes);

      final url =
          'https://fcm.googleapis.com/v1/projects/$projectId/messages:send';

      for (final tokenData in targetFcmTokens) {
        final token = tokenData.token;
        if (token.isEmpty) continue;

        final payload = {
          'message': {
            'token': token,
            'notification': {'title': title, 'body': body},
            'data': {
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'lang': tokenData.lang,
              ...data,
            },
          },
        };

        final response = await client.post(
          Uri.parse(url),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(payload),
        );

        if (response.statusCode == 200) {
          log('Notification sent successfully to $token');
        } else {
          log('Failed to send notification to $token: ${response.body}');
        }
      }

      client.close();
    } catch (e) {
      log('Error sending notification: $e');
    }
  }
}
