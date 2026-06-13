import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/core/values/app_font_style.dart';
import 'package:flowers_app/core/values/app_strings.dart';
import 'package:flowers_app/core/widgets/text_field/phone_field.dart';
import 'package:flowers_app/features/addresses/presentation/widgets/address_text_field.dart';
import 'package:flowers_app/features/checkout/presentation/cubit/checkout_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutGiftSection extends StatefulWidget {
  final TextEditingController usernameController;
  final TextEditingController phoneController;

  const CheckoutGiftSection({
    super.key,
    required this.usernameController,
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

    if (!isCredit) return const SizedBox.shrink();

    return Container(
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
                  value: isEnabled,
                  onChanged: (v) =>
                      context.read<CheckoutCubit>().doEvent(ToggleGift(v)),
                  activeThumbColor: AppColors.whiteF9,
                  activeTrackColor: AppColors.primerColor,
                  inactiveThumbColor: AppColors.primerColor,
                  inactiveTrackColor: AppColors.primerColor.withValues(
                    alpha: .1,
                  ),
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
          if (isEnabled) ...[
            AddressTextField(
              controller: widget.usernameController,
              label: AppStrings.enterRecipientName,
              hint: AppStrings.enterRecipientName,
              errorText: AppStrings.enterRecipientName,
            ),
            PhoneField(controller: widget.phoneController),
          ],
        ],
      ),
    );
  }
}
