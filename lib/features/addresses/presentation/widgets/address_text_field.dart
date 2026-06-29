import 'package:flutter/material.dart';

class AddressTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final String errorText;
  final TextInputType? keyboardType;
  final Widget? prefixIcon;

  const AddressTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.hint,
    required this.errorText,
    this.keyboardType,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: prefixIcon,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
      keyboardType: keyboardType,
      validator: (v) => (v == null || v.trim().isEmpty) ? errorText : null,
    );
  }
}
