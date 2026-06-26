import 'package:flutter/material.dart';
import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/features/track_order/domain/entities/track_order_status.dart';

class TrackOrderProgress extends StatelessWidget {
  const TrackOrderProgress({super.key, required this.status});

  final TrackOrderStatus status;

  @override
  Widget build(BuildContext context) {
    const steps = TrackOrderStatus.totalSteps;
    return Row(
      children: List.generate(steps, (index) {
        final reached = index < status.step;
        return Expanded(
          child: Container(
            height: 4,
            margin: EdgeInsets.only(right: index == steps - 1 ? 0 : 8),
            decoration: BoxDecoration(
              color: reached ? status.color : AppColors.grayCF,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        );
      }),
    );
  }
}
