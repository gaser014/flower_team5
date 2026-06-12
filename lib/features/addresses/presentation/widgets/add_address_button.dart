import 'package:flutter/material.dart';

import 'package:flowers_app/core/localization_constants/address_constants.dart';
import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/core/values/app_font_style.dart';

class AddAddressButton extends StatelessWidget {
  final VoidCallback onAdd;

  const AddAddressButton({super.key, required this.onAdd});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          onPressed: onAdd,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primerColor,
            foregroundColor: AppColors.whiteF9,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            elevation: 0,
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          child: Text(
            context.addNewAddress,
            style: AppFontStyle.medium18(context: context),
          ),
        ),
      ),
    );
  }
}
