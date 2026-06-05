import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/core/values/app_strings.dart';
import 'package:flutter/material.dart';

class PaymentActionsRow extends StatelessWidget {
  const PaymentActionsRow({
    super.key,
    required this.isLoading,
    required this.isFormValid,
    required this.savedPaymentMethod,
    required this.onSave,
    required this.onDelete,
  });

  final bool isLoading;
  final bool isFormValid;
  final String? savedPaymentMethod;
  final VoidCallback onSave;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: (isLoading || !isFormValid) ? null : onSave,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primerColor,
              disabledBackgroundColor: AppColors.gray7D,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: isLoading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppColors.white,
                    ),
                  )
                : Text(
                    AppStrings.saveCard,
                    style: const TextStyle(
                      fontSize: 16,
                      color: AppColors.white,
                    ),
                  ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: OutlinedButton(
            onPressed: (isLoading || savedPaymentMethod == null)
                ? null
                : onDelete,
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primerColor,
              padding: const EdgeInsets.symmetric(vertical: 16),
              side: const BorderSide(color: AppColors.primerColor),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            child: Text(
              AppStrings.deleteCard,
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ),
      ],
    );
  }
}
