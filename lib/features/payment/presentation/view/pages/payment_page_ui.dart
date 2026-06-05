import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/core/values/app_strings.dart';
import 'package:flowers_app/features/payment/presentation/view/widgets/payment_method_card.dart';
import 'package:flowers_app/features/payment/presentation/view/widgets/payment_actions_row.dart';
import 'package:flowers_app/features/payment/presentation/view/pages/payment_page_saved_card.dart';
import 'package:flowers_app/features/payment/presentation/view/pages/payment_page_form.dart';
import 'package:flutter/material.dart';

class PaymentPageUI extends StatelessWidget {
  const PaymentPageUI({
    super.key,
    required this.userEmail,
    required this.isCreditCard,
    required this.isLoading,
    required this.isFormValid,
    required this.savedPaymentMethod,
    required this.savedCardLast4,
    required this.formKey,
    required this.cardHolderController,
    required this.cardNumberController,
    required this.expiryController,
    required this.cvcController,
    required this.onSelectCredit,
    required this.onSelectCash,
    required this.onSave,
    required this.onDelete,
    required this.onFormChanged,
  });

  final String userEmail;
  final bool isCreditCard;
  final bool isLoading;
  final bool isFormValid;
  final String? savedPaymentMethod;
  final String? savedCardLast4;
  final GlobalKey<FormState> formKey;
  final TextEditingController cardHolderController;
  final TextEditingController cardNumberController;
  final TextEditingController expiryController;
  final TextEditingController cvcController;
  final VoidCallback onSelectCredit;
  final VoidCallback onSelectCash;
  final VoidCallback onSave;
  final VoidCallback onDelete;
  final VoidCallback onFormChanged;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.black,
        elevation: 0,
        title: Text(AppStrings.paymentMethod),
      ),
      backgroundColor: AppColors.whiteFD,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              userEmail.isNotEmpty
                  ? '${AppStrings.paymentLoggedInAs} $userEmail'
                  : AppStrings.paymentLoginHint,
              style: const TextStyle(fontSize: 14, color: AppColors.black85),
            ),
            const SizedBox(height: 20),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              color: AppColors.white,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: PaymentMethodCard(
                  isCreditCard: isCreditCard,
                  onSelectCredit: onSelectCredit,
                  onSelectCash: onSelectCash,
                  child: isCreditCard
                      ? Padding(
                          padding: const EdgeInsets.only(top: 12.0),
                          child: PaymentPageForm(
                            formKey: formKey,
                            cardHolderController: cardHolderController,
                            cardNumberController: cardNumberController,
                            expiryController: expiryController,
                            cvcController: cvcController,
                            onFormChanged: onFormChanged,
                          ),
                        )
                      : const SizedBox.shrink(),
                ),
              ),
            ),
            const SizedBox(height: 12),
            PaymentPageSavedCard(
              savedPaymentMethod: savedPaymentMethod,
              savedCardLast4: savedCardLast4,
            ),
            const SizedBox(height: 24),
            if (isCreditCard)
              PaymentActionsRow(
                isLoading: isLoading,
                isFormValid: isFormValid,
                savedPaymentMethod: savedPaymentMethod,
                onSave: onSave,
                onDelete: onDelete,
              ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
