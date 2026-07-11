import 'package:flowers_app/core/localization_constants/order_tracking_constants.dart';
import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/core/values/app_font_style.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

Future<void> showDriverArrivedSheet(BuildContext context) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => const _DriverArrivedSheet(),
  );
}

class _DriverArrivedSheet extends StatelessWidget {
  const _DriverArrivedSheet();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.whiteF9,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildIcon(),
              const Gap(16),
              _buildTitle(context),
              const Gap(8),
              _buildMessage(context),
              const Gap(24),
              _buildButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildIcon() {
    return const CircleAvatar(
      radius: 32,
      backgroundColor: AppColors.primerColor,
      child: Icon(Icons.check, color: AppColors.white, size: 36),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      context.driverArrivedTitle,
      textAlign: TextAlign.center,
      style: AppFontStyle.bold20(context: context),
    );
  }

  Widget _buildMessage(BuildContext context) {
    return Text(
      context.driverArrivedMessage,
      textAlign: TextAlign.center,
      style: AppFontStyle.regular14(
        context: context,
      ).copyWith(color: AppColors.gray53),
    );
  }

  Widget _buildButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () => Navigator.of(context).pop(),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primerColor,
          foregroundColor: AppColors.whiteF9,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Text(
          context.gotIt,
          style: AppFontStyle.semiBold16(
            context: context,
          ).copyWith(color: AppColors.whiteF9),
        ),
      ),
    );
  }
}
