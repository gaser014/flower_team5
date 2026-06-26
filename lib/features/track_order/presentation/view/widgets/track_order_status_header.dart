import 'package:flutter/material.dart';
import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/core/values/app_font_style.dart';
import 'package:flowers_app/features/track_order/domain/entities/track_order_status.dart';
import 'package:gap/gap.dart';

class TrackOrderStatusHeader extends StatelessWidget {
  const TrackOrderStatusHeader({super.key, required this.status});

  final TrackOrderStatus status;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: status.color,
            shape: BoxShape.circle,
          ),
          child: Icon(status.icon, color: AppColors.whiteF9, size: 20),
        ),
        const Gap(8),
        Text(
          status.label,
          textAlign: TextAlign.center,
          style: AppFontStyle.medium16(
            context: context,
          ).copyWith(color: AppColors.black0C),
        ),
      ],
    );
  }
}
