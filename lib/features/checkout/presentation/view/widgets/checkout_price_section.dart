import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/core/values/app_font_style.dart';
import 'package:flowers_app/core/values/app_strings.dart';
import 'package:flowers_app/core/widgets/custom_button.dart';
import 'package:flowers_app/features/checkout/presentation/view_model/cubit/checkout_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CheckoutPriceSection extends StatelessWidget {
  final int subtotal;
  final VoidCallback? onPlaceOrder;

  const CheckoutPriceSection({
    super.key,
    required this.subtotal,
    required this.onPlaceOrder,
  });

  @override
  Widget build(BuildContext context) {
    const delivery = 10;
    final total = subtotal + delivery;
    final isLoading = context.select<CheckoutCubit, bool>(
      (c) => c.state.checkoutState.isLoading,
    );

    return Container(
      padding: const EdgeInsets.all(16),
      color: AppColors.whiteF9,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppStrings.subTotal,
                style: AppFontStyle.regular16(
                  context: context,
                ).copyWith(color: AppColors.gray53),
              ),
              Text(
                '\$$subtotal',
                style: AppFontStyle.regular16(
                  context: context,
                ).copyWith(color: AppColors.gray53),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '\$$delivery',
                style: AppFontStyle.regular16(
                  context: context,
                ).copyWith(color: AppColors.gray53),
              ),
              Text(
                AppStrings.deliveryFee,
                style: AppFontStyle.regular16(
                  context: context,
                ).copyWith(color: AppColors.gray53),
              ),
              Text(
                '\$$delivery',
                style: AppFontStyle.regular16(
                  context: context,
                ).copyWith(color: AppColors.gray53),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 12),
            child: Divider(color: AppColors.gray53),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                AppStrings.totalPrice,
                style: AppFontStyle.medium18(
                  context: context,
                ).copyWith(color: AppColors.black0C),
              ),
              const Spacer(),
              Text(
                '\$$total',
                style: AppFontStyle.medium18(
                  context: context,
                ).copyWith(color: AppColors.black0C),
              ),
            ],
          ),
          const SizedBox(height: 44),
          CustomButton(
            onPressed: onPlaceOrder,
            text: AppStrings.placeOrder,
            isLoading: isLoading,
          CustomButton(
            text: AppStrings.placeOrder,
            onPressed: onPlaceOrder,
            isLoading: isLoading,

          ),
        ],
      ),
    );
  }
}
