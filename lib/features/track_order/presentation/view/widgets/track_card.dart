import 'package:flutter/material.dart';
import 'package:flowers_app/core/values/app_colors.dart';

class TrackCard extends StatelessWidget {
  const TrackCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
  });

  final Widget child;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: AppColors.whiteF9,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [BoxShadow(color: Color(0x40535353), blurRadius: 2)],
      ),
      child: child,
    );
  }
}
