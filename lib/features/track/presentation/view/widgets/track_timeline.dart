import 'package:flowers_app/core/values/app_strings.dart';
import 'package:flowers_app/features/track/presentation/view/widgets/track_timeline_item.dart';
import 'package:flutter/material.dart';

/// Renders the 4-step delivery timeline. [step] comes from
/// `TrackOrderStatus.step` (1 = accepted … 4 = delivered) and uses the same
/// `index < step` highlight logic as the driver app so both progress in lockstep.
class TrackTimeline extends StatelessWidget {
  final int step;

  const TrackTimeline({super.key, required this.step});

  static const _titles = [
    AppStrings.receivedOrder,
    AppStrings.preparingOrder,
    AppStrings.outForDelivery,
    AppStrings.statusDelivered,
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(_titles.length, (index) {
        return TrackTimelineItem(
          title: _titles[index],
          isActive: index < step,
          isLast: index == _titles.length - 1,
        );
      }),
    );
  }
}
