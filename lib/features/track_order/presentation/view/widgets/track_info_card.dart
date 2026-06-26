import 'package:flutter/material.dart';
import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/core/values/app_font_style.dart';
import 'package:flowers_app/features/track_order/presentation/view/widgets/track_card.dart';
import 'package:gap/gap.dart';

class TrackInfoCard extends StatelessWidget {
  const TrackInfoCard({
    super.key,
    required this.leading,
    required this.title,
    this.subtitle,
  });

  final Widget leading;
  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return TrackCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(width: 24, height: 24, child: leading),
              const Gap(8),
              Expanded(
                child: Text(
                  title,
                  style: AppFontStyle.medium16(
                    context: context,
                  ).copyWith(color: AppColors.black0C),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          if (subtitle != null && subtitle!.isNotEmpty) ...[
            const Gap(16),
            Text(
              subtitle!,
              style: AppFontStyle.regular13(
                context: context,
              ).copyWith(color: AppColors.gray53),
            ),
          ],
        ],
      ),
    );
  }
}
