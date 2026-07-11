import 'package:cached_network_image/cached_network_image.dart';
import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/core/values/app_font_style.dart';
import 'package:flowers_app/core/values/app_strings.dart';
import 'package:flowers_app/features/track/domain/entities/track_order_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

/// Shows the assigned delivery hero. Falls back to a "waiting for driver"
/// state while the order has not been picked up by anyone yet.
class TrackDriverInfo extends StatelessWidget {
  final TrackDriverEntity driver;

  const TrackDriverInfo({super.key, required this.driver});

  @override
  Widget build(BuildContext context) {
    final hasDriver = !driver.isEmpty;
    final name = hasDriver ? driver.name : AppStrings.waitingForDriver;

    return Row(
      children: [
        _DriverAvatar(photo: driver.photo),
        Gap(10.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name.isEmpty ? AppStrings.deliveryHero : name,
                style: AppFontStyle.bold14(),
              ),
              Text(
                AppStrings.deliveryHero,
                style: AppFontStyle.medium12().copyWith(
                  color: AppColors.black85,
                ),
              ),
            ],
          ),
        ),
        if (hasDriver) ...[
          Icon(Icons.phone, color: AppColors.primerColor, size: 24.r),
          Gap(15.w),
          Icon(
            Icons.chat_bubble_outline,
            color: AppColors.primerColor,
            size: 24.r,
          ),
        ],
      ],
    );
  }
}

class _DriverAvatar extends StatelessWidget {
  final String photo;

  const _DriverAvatar({required this.photo});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 20.r,
      backgroundColor: AppColors.pinkF9,
      backgroundImage: photo.isNotEmpty
          ? CachedNetworkImageProvider(photo)
          : null,
      child: photo.isEmpty
          ? Icon(Icons.person, color: AppColors.primerColor, size: 20.r)
          : null,
    );
  }
}
