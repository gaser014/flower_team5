import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/core/values/app_font_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class TrackTimelineItem extends StatelessWidget {
  final String title;
  final String? subtitle;
  final bool isActive;
  final bool isLast;

  const TrackTimelineItem({
    super.key,
    required this.title,
    this.subtitle,
    required this.isActive,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
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
              if (subtitle != null) ...[
                Gap(2.h),
                Text(
                  subtitle!,
                  style: AppFontStyle.medium12().copyWith(
                    color: AppColors.black85,
                  ),
                ),
              ],
              if (!isLast) Gap(20.h),
            ],
          ),
        ),
      ],
    );
  }
}
