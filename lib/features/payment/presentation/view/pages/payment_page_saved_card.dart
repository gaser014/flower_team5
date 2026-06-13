import 'package:flowers_app/core/values/app_strings.dart';
import 'package:flutter/material.dart';

class PaymentPageSavedCard extends StatelessWidget {
  const PaymentPageSavedCard({
    super.key,
    required this.savedPaymentMethod,
    required this.savedCardLast4,
  });

  final String? savedPaymentMethod;
  final String? savedCardLast4;

  @override
  Widget build(BuildContext context) {
    if (savedPaymentMethod == null) {
      return Text(AppStrings.noSavedCard);
    }

    if (savedPaymentMethod == 'creditCard') {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppStrings.savedCardDetails,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 8),
          Text('${AppStrings.cardEnding}: ${savedCardLast4 ?? ''}'),
        ],
      );
    }

    return Text(AppStrings.noSavedCard);
  }
}
