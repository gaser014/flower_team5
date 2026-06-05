import 'package:flowers_app/core/values/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ExpiryCvcFields extends StatelessWidget {
  const ExpiryCvcFields({
    super.key,
    required this.expiryController,
    required this.cvcController,
    required this.onFieldsChanged,
  });

  final TextEditingController expiryController;
  final TextEditingController cvcController;
  final VoidCallback onFieldsChanged;

  String _formatExpiry(String value) {
    String cleaned = value.replaceAll(RegExp(r'[^\d]'), '');
    if (cleaned.length > 4) {
      cleaned = cleaned.substring(0, 4);
    }
    if (cleaned.length >= 2) {
      return '${cleaned.substring(0, 2)}/${cleaned.substring(2)}';
    }
    return cleaned;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: expiryController,
            decoration: InputDecoration(
              labelText: AppStrings.expiryDate,
              hintText: AppStrings.enterExpiryDate,
              border: const OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            onChanged: (value) {
              final formatted = _formatExpiry(value);
              expiryController.value = TextEditingValue(
                text: formatted,
                selection: TextSelection.fromPosition(
                  TextPosition(offset: formatted.length),
                ),
              );
              onFieldsChanged();
            },
            textInputAction: TextInputAction.next,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return AppStrings.invalidExpiryDate;
              }
              final regex = RegExp(r'^(0[1-9]|1[0-2])/\d{2}\$');
              if (!regex.hasMatch(value.trim())) {
                return AppStrings.invalidExpiryDate;
              }
              return null;
            },
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: TextFormField(
            controller: cvcController,
            decoration: InputDecoration(
              labelText: AppStrings.cvc,
              hintText: AppStrings.enterCvc,
              border: const OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(3),
            ],
            textInputAction: TextInputAction.done,
            validator: (value) {
              if (value == null || value.trim().length != 3) {
                return AppStrings.invalidCvc;
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}
