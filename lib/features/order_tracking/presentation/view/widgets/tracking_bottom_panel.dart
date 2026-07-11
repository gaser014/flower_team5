import 'package:flowers_app/core/localization_constants/order_tracking_constants.dart';
import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/core/values/app_font_style.dart';
import 'package:flowers_app/features/order_tracking/presentation/view/widgets/delivery_man_row.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class TrackingBottomPanel extends StatelessWidget {
  const TrackingBottomPanel({
    super.key,
    required this.hasDriver,
    required this.estimatedArrival,
    required this.durationText,
    this.hasArrived = false,
    this.driverName = '',
    this.driverPhoto = '',
    this.onOrderDetails,
    this.onCall,
    this.onChat,
  });

  final bool hasDriver;
  final bool hasArrived;
  final String driverName;
  final String driverPhoto;
  final DateTime? estimatedArrival;
  final String durationText;
  final VoidCallback? onOrderDetails;
  final VoidCallback? onCall;
  final VoidCallback? onChat;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.whiteF9,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: [BoxShadow(color: Color(0x1A000000), blurRadius: 8)],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildArrival(context),
              const Gap(16),
              const Divider(height: 1, thickness: 1, color: AppColors.grayEA),
              const Gap(24),
              _buildDelivery(context),
              const Gap(40),
              _buildButton(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildArrival(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.estimatedArrival,
            style: AppFontStyle.medium14(
              context: context,
            ).copyWith(color: AppColors.gray53),
          ),
          const Gap(8),
          Text(
            _arrivalValue(context),
            style: AppFontStyle.medium16(
              context: context,
            ).copyWith(color: AppColors.black0C),
          ),
        ],
      ),
    );
  }

  Widget _buildDelivery(BuildContext context) {
    if (!hasDriver) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Align(
          alignment: AlignmentDirectional.centerStart,
          child: Text(
            context.waitingForDriver,
            style: AppFontStyle.medium14(
              context: context,
            ).copyWith(color: AppColors.gray53),
          ),
        ),
      );
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: DeliveryManRow(
        driverName: driverName,
        driverPhoto: driverPhoto,
        onCall: onCall,
        onChat: onChat,
      ),
    );
  }

  Widget _buildButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          onPressed: onOrderDetails,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primerColor,
            foregroundColor: AppColors.whiteF9,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
          child: Text(
            context.orderDetailsButton,
            style: AppFontStyle.medium18(context: context),
          ),
        ),
      ),
    );
  }

  String _arrivalValue(BuildContext context) {
    if (hasArrived) return context.arrivedLabel;
    final arrival = estimatedArrival;
    if (arrival != null) return _formatDateTime(arrival);
    if (durationText.isNotEmpty) return durationText;
    return context.calculatingArrival;
  }

  String _formatDateTime(DateTime dt) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    final day = dt.day.toString().padLeft(2, '0');
    final month = months[dt.month - 1];
    final hour12 = dt.hour % 12 == 0 ? 12 : dt.hour % 12;
    final minute = dt.minute.toString().padLeft(2, '0');
    final period = dt.hour < 12 ? 'AM' : 'PM';
    return '$day $month ${dt.year}, '
        '${hour12.toString().padLeft(2, '0')}:$minute $period';
  }
}
