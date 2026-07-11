import 'package:flowers_app/core/localization_constants/order_tracking_constants.dart';
import 'package:flowers_app/core/routes/routes.dart';
import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/core/values/app_font_style.dart';
import 'package:flowers_app/core/values/app_strings.dart';
import 'package:flowers_app/features/order_tracking/domain/entities/order_tracking_args.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ThankYouScreen extends StatelessWidget {
  const ThankYouScreen({super.key, this.orderId, this.orderNumber});

  final String? orderId;
  final String? orderNumber;

  bool get _canTrack =>
      (orderId?.isNotEmpty ?? false) || (orderNumber?.isNotEmpty ?? false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteF9,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 2),
              _buildBadge(),
              const SizedBox(height: 32),
              _buildTitle(context),
              const SizedBox(height: 16),
              _buildMessage(context),
              const Spacer(flex: 2),
              if (_canTrack) ...[
                _buildTrackButton(context),
                const SizedBox(height: 12),
              ],
              _buildContinueButton(context),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBadge() {
    return Container(
      width: 120,
      height: 120,
      decoration: const BoxDecoration(
        color: AppColors.primerColor,
        shape: BoxShape.circle,
      ),
      child: const Icon(Icons.check, size: 64, color: AppColors.white),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      AppStrings.orderPlaced,
      textAlign: TextAlign.center,
      style: AppFontStyle.bold24(context: context),
    );
  }

  Widget _buildMessage(BuildContext context) {
    return Text(
      AppStrings.thankYouMessage,
      textAlign: TextAlign.center,
      style: AppFontStyle.regular16(
        context: context,
      ).copyWith(color: AppColors.gray53),
    );
  }

  Widget _buildTrackButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () => context.pushNamed(
          Routes.orderTracking,
          extra: OrderTrackingArgs(
            orderId: orderId ?? '',
            orderNumber: orderNumber ?? '',
          ),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primerColor,
          foregroundColor: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        child: Text(
          context.trackOrder,
          style: AppFontStyle.semiBold16(context: context),
        ),
      ),
    );
  }

  Widget _buildContinueButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () => context.goNamed(Routes.main),
        style: ElevatedButton.styleFrom(
          backgroundColor: _canTrack ? AppColors.white : AppColors.primerColor,
          foregroundColor: _canTrack ? AppColors.primerColor : AppColors.white,
          side: _canTrack
              ? const BorderSide(color: AppColors.primerColor)
              : BorderSide.none,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        child: Text(
          AppStrings.continueShopping,
          style: AppFontStyle.semiBold16(context: context),
        ),
      ),
    );
  }
}
