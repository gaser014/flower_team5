import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/core/values/app_font_style.dart';
import 'package:flowers_app/core/values/app_strings.dart';
import 'package:flowers_app/features/track/domain/entities/track_order_entity.dart';
import 'package:flowers_app/features/track/presentation/view/widgets/track_time_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

/// Shows the order number and the estimated arrival / last update time.
class TrackArrivalHeader extends StatelessWidget {
  final TrackOrderEntity order;

  const TrackArrivalHeader({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (order.orderNumber.isNotEmpty)
          Text(
            '${AppStrings.orderNumberLabel} #${order.orderNumber}',
            style: AppFontStyle.medium12().copyWith(color: AppColors.black85),
          ),
        Gap(8.h),
        Text(
          AppStrings.estimatedArrival,
          style: AppFontStyle.medium14().copyWith(color: AppColors.black85),
        ),
        Gap(5.h),
        Text(formatTrackDateTime(order.updatedAt), style: AppFontStyle.bold16()),
      ],
    );
  }
}
