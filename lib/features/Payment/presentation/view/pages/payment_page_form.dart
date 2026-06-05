import 'package:flowers_app/core/values/app_strings.dart';
import 'package:flutter/material.dart';
import 'payment_card_number_field.dart';
import 'payment_card_expiry_cvc_fields.dart';

class CreditCardFormSection extends StatelessWidget {
  const CreditCardFormSection({
    super.key,
    required this.formKey,
    required this.cardHolderController,
    required this.cardNumberController,
    required this.expiryController,
    required this.cvcController,
    required this.onFieldsChanged,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController cardHolderController;
  final TextEditingController cardNumberController;
  final TextEditingController expiryController;
  final TextEditingController cvcController;
  final VoidCallback onFieldsChanged;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            controller: cardHolderController,
            decoration: InputDecoration(
              labelText: AppStrings.cardHolderName,
              hintText: AppStrings.enterCardHolderName,
              border: const OutlineInputBorder(),
            ),
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return AppStrings.nameRequired;
              }
              return null;
            },
          ),
          const SizedBox(height: 12),
          CardNumberField(
            cardNumberController: cardNumberController,
            onFieldsChanged: onFieldsChanged,
          ),
          const SizedBox(height: 12),
          ExpiryCvcFields(
            expiryController: expiryController,
            cvcController: cvcController,
            onFieldsChanged: onFieldsChanged,
          ),
        ],
      ),
    );
  }
}
