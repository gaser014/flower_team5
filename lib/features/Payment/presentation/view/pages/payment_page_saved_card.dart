import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/core/values/app_strings.dart';
import 'package:flutter/material.dart';

class SavedPaymentDetailsSection extends StatelessWidget {
  const SavedPaymentDetailsSection({
    super.key,
    required this.savedPaymentMethod,
    required this.savedCardLast4,
  });

  final String? savedPaymentMethod;
  final String? savedCardLast4;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: AppColors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.savedCardDetails,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            if (savedPaymentMethod == null) ...[
              Text(
                AppStrings.noSavedCard,
                style: const TextStyle(color: AppColors.gray7D),
              ),
            ] else ...[
              Text(
                '${AppStrings.method}: ${savedPaymentMethod == 'creditCard' ? AppStrings.creditCard : AppStrings.cash}',
                style: const TextStyle(fontSize: 14),
              ),
              if (savedPaymentMethod == 'creditCard' &&
                  savedCardLast4 != null) ...[
                const SizedBox(height: 8),
                Text(
                  '${AppStrings.cardEnding} $savedCardLast4',
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }
}
