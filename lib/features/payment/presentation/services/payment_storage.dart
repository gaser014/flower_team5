import 'dart:convert';

import 'package:flowers_app/config/database/cache_helper.dart';

class PaymentStorage {
  const PaymentStorage._();

  static Future<Map<String, dynamic>?> loadSaved(String email) async {
    final key = 'payment_card_$email';
    final jsonStr = await AppSharedPreferences.getString(key: key);
    if (jsonStr == null || jsonStr.isEmpty) return null;
    final map = jsonDecode(jsonStr) as Map<String, dynamic>?;
    return map;
  }

  static Future<bool> save(String email, Map<String, dynamic> data) async {
    final key = 'payment_card_$email';
    final saved = await AppSharedPreferences.setString(
      key: key,
      value: jsonEncode(data),
    );
    if (!saved) return false;
    final delKey = 'payment_card_deleted_$email';
    await AppSharedPreferences.remove(key: delKey);
    return true;
  }

  static Future<bool> delete(String email) async {
    final key = 'payment_card_$email';
    final removed = await AppSharedPreferences.remove(key: key);
    final delKey = 'payment_card_deleted_$email';
    await AppSharedPreferences.setBool(key: delKey, value: true);
    return removed;
  }

  static Future<bool> isDeleted(String email) async {
    final delKey = 'payment_card_deleted_$email';
    final value = await AppSharedPreferences.getBool(key: delKey);
    return value == true;
  }

  static Future<void> clearDeleted(String email) async {
    final delKey = 'payment_card_deleted_$email';
    await AppSharedPreferences.remove(key: delKey);
  }
}
