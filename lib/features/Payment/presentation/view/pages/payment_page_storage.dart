import 'dart:convert';

import 'package:flowers_app/config/database/cache_helper.dart';
import 'package:flowers_app/core/values/app_strings.dart';

class PaymentCardData {
  const PaymentCardData({
    required this.email,
    this.method,
    this.cardNumber,
    this.cardHolder,
    this.expiry,
    this.cvc,
  });

  final String email;
  final String? method;
  final String? cardNumber;
  final String? cardHolder;
  final String? expiry;
  final String? cvc;
}

class PaymentPageStorage {
  static String _storageKey(String email) => 'payment_card_$email';

  static Future<PaymentCardData?> loadSavedCardData() async {
    final userJson = await AppSharedPreferences.getString(key: AppStrings.user);
    if (userJson == null || userJson.isEmpty) {
      return null;
    }

    final userMap = jsonDecode(userJson) as Map<String, dynamic>?;
    final email = userMap?['email'] as String?;
    if (email == null || email.isEmpty) {
      return null;
    }

    final savedJson = await AppSharedPreferences.getString(
      key: _storageKey(email),
    );
    if (savedJson == null || savedJson.isEmpty) {
      return PaymentCardData(email: email);
    }

    final savedMap = jsonDecode(savedJson) as Map<String, dynamic>?;
    if (savedMap == null) {
      return PaymentCardData(email: email);
    }

    return PaymentCardData(
      email: email,
      method: savedMap['method'] as String?,
      cardNumber: savedMap['cardNumber'] as String?,
      cardHolder: savedMap['cardHolder'] as String?,
      expiry: savedMap['expiry'] as String?,
      cvc: savedMap['cvc'] as String?,
    );
  }

  static Future<bool> savePaymentData(
    String email,
    Map<String, dynamic> paymentData,
  ) async {
    return AppSharedPreferences.setString(
      key: _storageKey(email),
      value: jsonEncode(paymentData),
    );
  }
}
