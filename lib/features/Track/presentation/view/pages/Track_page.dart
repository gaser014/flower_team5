import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:track_flowers_app/core/values/app_colors.dart';
import 'package:track_flowers_app/core/values/app_font_style.dart';
import 'package:track_flowers_app/core/values/app_strings.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class TrackPage extends StatelessWidget {
  final bool isDelivered;
  
  const TrackPage({super.key, this.isDelivered = false});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteF9,
      appBar: AppBar(
        title: Text(AppStrings.trackOrder, style: AppFontStyle.bold18()),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Gap(20.h),
            Text(
              AppStrings.estimatedArrival,
              style: AppFontStyle.medium14().copyWith(color: AppColors.black85),
            ),
            Gap(5.h),
            Text('03 Sep 2024, 11:00 AM', style: AppFontStyle.bold16()),
            Gap(20.h),
            // Driver info card
            Row(
              children: [
                CircleAvatar(
                  radius: 20.r,
                  backgroundColor: AppColors.pinkF9,
                  child: Icon(
                    Icons.person,
                    color: AppColors.primerColor,
                    size: 20.r,
                  ),
                ),
                Gap(10.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Muhamed', style: AppFontStyle.bold14()),
                      Text(
                        AppStrings.deliveryHero,
                        style: AppFontStyle.medium12().copyWith(
                          color: AppColors.black85,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.phone, color: AppColors.primerColor, size: 24.r),
                Gap(15.w),
                Icon(
                  Icons.chat_bubble_outline,
                  color: AppColors.primerColor,
                  size: 24.r,
                ),
              ],
            ),
            Gap(20.h),
            // Car animation
            Center(
              child: SizedBox(
                height: 180.h,
                child: Lottie.asset('assets/json/carpool.json'),
              ),
            ),
            Gap(20.h),
            // Timeline
            Expanded(child: _buildTimeline()),
            Gap(10.h),
            // Bottom button
            if (isDelivered)
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 50.h,
                      child: ElevatedButton(
                        onPressed: () {
                          context.push('/track-map');
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primerColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        child: Text(
                          AppStrings.showMap,
                          style: AppFontStyle.bold16().copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  Gap(10.w),
                  Expanded(
                    child: SizedBox(
                      height: 50.h,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primerColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        child: Text(
                          AppStrings.orderDelivered,
                          style: AppFontStyle.bold16().copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            else
              SizedBox(
                width: double.infinity,
                height: 50.h,
                child: ElevatedButton(
                  onPressed: () {
                    context.push('/track-map');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primerColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    AppStrings.showMap,
                    style: AppFontStyle.bold16().copyWith(color: Colors.white),
                  ),
                ),
              ),
            Gap(20.h),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeline() {
    return Column(
      children: [
        _buildTimelineItem(
          AppStrings.receivedOrder,
          '03 Sep 2024 - 2:10',
          true,
          false,
        ),
        _buildTimelineItem(
          AppStrings.preparingOrder,
          '03 Sep 2024 - 2:10',
          isDelivered,
          false,
        ),
        _buildTimelineItem(
          AppStrings.outForDelivery,
          '03 Sep 2024 - 2:10',
          isDelivered,
          false,
        ),
        _buildTimelineItem(AppStrings.statusDelivered, '03 Sep 2024 - 2:10', isDelivered, true),
      ],
    );
  }

  Widget _buildTimelineItem(
    String title,
    String subtitle,
    bool isActive,
    bool isLast,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              height: 20.h,
              width: 20.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isActive ? AppColors.primerColor : AppColors.grayA6,
                  width: isActive ? 6 : 2,
                ),
              ),
            ),
            if (!isLast)
              Container(
                height: 40.h,
                width: 2.w,
                color: isActive ? AppColors.primerColor : AppColors.grayA6,
              ),
          ],
        ),
        Gap(15.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppFontStyle.bold14()),
              Gap(2.h),
              Text(
                subtitle,
                style: AppFontStyle.medium12().copyWith(
                  color: AppColors.black85,
                ),
              ),
              if (!isLast) Gap(20.h),
            ],
          ),
        ),
      ],
    );
  }
}
