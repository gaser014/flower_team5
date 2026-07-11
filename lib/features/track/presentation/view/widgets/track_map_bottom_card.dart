import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/core/values/app_font_style.dart';
import 'package:flowers_app/core/values/app_strings.dart';
import 'package:flowers_app/features/track/domain/entities/track_order_entity.dart';
import 'package:flowers_app/features/track/presentation/view/widgets/track_driver_info.dart';
import 'package:flowers_app/features/track/presentation/view/widgets/track_time_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class TrackMapBottomCard extends StatelessWidget {
  final TrackOrderEntity order;

  const TrackMapBottomCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _ArrivalInfo(order: order),
            Gap(20.h),
            TrackDriverInfo(driver: order.driver),
            Gap(20.h),
            const _OrderDetailsButton(),
            Gap(MediaQuery.of(context).padding.bottom),
          ],
        ),
      ),
    );
  }
}

class _ArrivalInfo extends StatelessWidget {
  final TrackOrderEntity order;

  const _ArrivalInfo({required this.order});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.estimatedArrival,
          style: AppFontStyle.medium14().copyWith(color: AppColors.black85),
        ),
        Gap(5.h),
        Text(
          formatTrackDateTime(order.updatedAt),
          style: AppFontStyle.bold16(),
        ),
      ],
    );
  }
}

class _OrderDetailsButton extends StatelessWidget {
  const _OrderDetailsButton();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50.h,
      child: ElevatedButton(
        onPressed: () {
          if (Navigator.canPop(context)) Navigator.pop(context);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primerColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        child: Text(
          AppStrings.orderDetails,
          style: AppFontStyle.bold16().copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
