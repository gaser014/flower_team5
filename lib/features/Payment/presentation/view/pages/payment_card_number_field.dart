import 'package:flowers_app/core/values/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CardNumberField extends StatelessWidget {
  const CardNumberField({
    super.key,
    required this.cardNumberController,
    required this.onFieldsChanged,
  });

  final TextEditingController cardNumberController;
  final VoidCallback onFieldsChanged;

  String _formatCardNumber(String value) {
    String cleaned = value.replaceAll(' ', '');
    if (cleaned.length > 16) {
      cleaned = cleaned.substring(0, 16);
    }
    final buffer = StringBuffer();
    for (var i = 0; i < cleaned.length; i++) {
      if (i > 0 && i % 4 == 0) {
        buffer.write(' ');
      }
      buffer.write(cleaned[i]);
    }
    return buffer.toString();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: cardNumberController,
      decoration: InputDecoration(
        labelText: AppStrings.cardNumber,
        hintText: AppStrings.enterCardNumber,
        border: const OutlineInputBorder(),
      ),
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      onChanged: (value) {
        final formatted = _formatCardNumber(value);
        cardNumberController.value = TextEditingValue(
          text: formatted,
          selection: TextSelection.fromPosition(
            TextPosition(offset: formatted.length),
          ),
        );
        onFieldsChanged();
      },
      textInputAction: TextInputAction.next,
      validator: (value) {
        if (value == null || value.trim().replaceAll(' ', '').length != 16) {
          return AppStrings.invalidCardNumber;
        }
        return null;
      },
    );
  }
}
