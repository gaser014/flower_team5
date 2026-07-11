import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/core/values/app_font_style.dart';
import 'package:flowers_app/core/values/app_strings.dart';
import 'package:flowers_app/features/track/domain/entities/track_order_entity.dart';
import 'package:flowers_app/features/track/presentation/view/widgets/track_arrival_header.dart';
import 'package:flowers_app/features/track/presentation/view/widgets/track_bottom_buttons.dart';
import 'package:flowers_app/features/track/presentation/view/widgets/track_car_animation.dart';
import 'package:flowers_app/features/track/presentation/view/widgets/track_driver_info.dart';
import 'package:flowers_app/features/track/presentation/view/widgets/track_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

/// The main tracking layout shown once an order has been resolved. Rebuilds
/// automatically as the cubit emits fresh snapshots from Firebase.
class TrackContent extends StatelessWidget {
  final TrackOrderEntity order;

  const TrackContent({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gap(20.h),
        TrackArrivalHeader(order: order),
        Gap(20.h),
        TrackDriverInfo(driver: order.driver),
        Gap(20.h),
        if (order.status.isCancelled)
          const _CancelledBanner()
        else
          const TrackCarAnimation(),
        Gap(20.h),
        Expanded(
          child: SingleChildScrollView(
            child: TrackTimeline(step: order.status.step),
          ),
        ),
        Gap(10.h),
        TrackBottomButtons(status: order.status),
        Gap(20.h),
      ],
    );
  }
}

class _CancelledBanner extends StatelessWidget {
  const _CancelledBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: AppColors.pinkF9,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Text(
        AppStrings.orderCancelled,
        textAlign: TextAlign.center,
        style: AppFontStyle.bold16().copyWith(color: AppColors.primerColor),
      ),
    );
  }
}
