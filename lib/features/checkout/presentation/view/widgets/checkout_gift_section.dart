import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/core/values/app_font_style.dart';
import 'package:flowers_app/core/values/app_strings.dart';
import 'package:flowers_app/features/checkout/presentation/view_model/cubit/checkout_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutGiftSection extends StatefulWidget {
  final TextEditingController nameController;
  final TextEditingController phoneController;

  const CheckoutGiftSection({
    super.key,
    required this.nameController,
    required this.phoneController,
  });

  @override
  State<CheckoutGiftSection> createState() => _CheckoutGiftSectionState();
}

class _CheckoutGiftSectionState extends State<CheckoutGiftSection> {
  @override
  Widget build(BuildContext context) {
    final isCredit =
        context.select<CheckoutCubit, int>((c) => c.state.selectedPayment) == 1;
    final isEnabled = context.select<CheckoutCubit, bool>(
      (c) => c.state.isGift,
    );

    return AbsorbPointer(
      absorbing: !isCredit,
      child: Container(
        padding: const EdgeInsets.all(16),
        color: AppColors.whiteF9,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16,
          children: [
            Row(
              spacing: 8,
              children: [
                SizedBox(
                  height: 24,
                  child: Switch.adaptive(
                    value: isCredit ? isEnabled : false,
                    onChanged: (v) => context.read<CheckoutCubit>().doIntent(
                      ToggleGiftEvent(v),
                    ),
                    activeThumbColor: AppColors.whiteF9,
                    activeTrackColor: AppColors.primerColor,
                    inactiveThumbColor: AppColors.primerColor,
                    inactiveTrackColor: AppColors.whiteF9,
                  ),
                ),
                Text(
                  AppStrings.itIsAGift,
                  style: AppFontStyle.medium18(
                    context: context,
                  ).copyWith(color: AppColors.black0C),
                ),
              ],
            ),
            SizedBox(
              height: 56,
              child: TextField(
                controller: widget.nameController,
                decoration: InputDecoration(
                  labelText: AppStrings.nameLabel,
                  hintText: AppStrings.enterNameHint,
                  labelStyle: const TextStyle(
                    color: AppColors.gray53,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                  hintStyle: const TextStyle(
                    color: AppColors.grayA6,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(color: AppColors.gray53),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(color: AppColors.gray53),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(color: AppColors.gray53),
                  ),
                  contentPadding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
                ),
              ),
            ),
            SizedBox(
              height: 56,
              child: TextField(
                controller: widget.phoneController,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: AppStrings.phoneNumber,
                  hintText: AppStrings.enterPhoneHint,
                  labelStyle: const TextStyle(
                    color: AppColors.gray53,
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                  hintStyle: const TextStyle(
                    color: AppColors.grayA6,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(color: AppColors.gray53),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(color: AppColors.gray53),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: const BorderSide(color: AppColors.gray53),
                  ),
                  contentPadding: const EdgeInsets.fromLTRB(16, 4, 16, 4),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
