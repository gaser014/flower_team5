import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/core/values/app_font_style.dart';
import 'package:flowers_app/core/values/input_formatters.dart';
import 'package:flowers_app/core/validations/validations.dart';
import 'package:flutter/material.dart';

class NameField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final String hintText;
  final String? Function(String?)? validator;
  final bool enabled;
  final TextInputAction? textInputAction;
  final void Function(String)? onFieldSubmitted;
  final FocusNode? focusNode;

  const NameField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.hintText,
    this.validator,
    this.enabled = true,
    this.textInputAction,
    this.onFieldSubmitted,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      enabled: enabled,
      keyboardType: TextInputType.name,
      textInputAction: textInputAction ?? TextInputAction.next,
      inputFormatters: AppInputFormatters.name,
      validator: validator ?? Validations.validateName,
      onFieldSubmitted: onFieldSubmitted,
      autofillHints: const [AutofillHints.name],
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        hintStyle: AppFontStyle.regular14().copyWith(color: AppColors.grayA6),
      ),
    );
  }
}
