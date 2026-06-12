import 'package:flutter/material.dart';

import 'package:flowers_app/core/localization_constants/address_constants.dart';
import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/core/values/app_font_style.dart';

class DeleteAddressSheet extends StatelessWidget {
  const DeleteAddressSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            context.deleteAddressTitle,
            style: AppFontStyle.medium20(context: context),
          ),
          const SizedBox(height: 16),
          Text(
            context.deleteAddressMessage,
            style: AppFontStyle.regular14(context: context)
                .copyWith(color: AppColors.gray53),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          Row(
            children: [
              Expanded(
                child: _SheetButton(
                  label: context.cancel,
                  onPressed: () => Navigator.pop(context, false),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _SheetButton(
                  label: context.delete,
                  backgroundColor: AppColors.redCC,
                  foregroundColor: AppColors.whiteF9,
                  onPressed: () => Navigator.pop(context, true),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SheetButton extends StatelessWidget {
  final String label;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final VoidCallback onPressed;

  const _SheetButton({
    required this.label,
    this.backgroundColor,
    this.foregroundColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? AppColors.whiteF9,
        foregroundColor: foregroundColor ?? AppColors.black0C,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: backgroundColor != null
              ? BorderSide.none
              : const BorderSide(color: AppColors.gray53),
        ),
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 14),
      ),
      child: Text(label, style: AppFontStyle.medium16(context: context)),
    );
  }
}
