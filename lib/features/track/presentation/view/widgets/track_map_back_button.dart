import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TrackMapBackButton extends StatelessWidget {
  const TrackMapBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 50.h,
      left: 20.w,
      child: InkWell(
        onTap: () {
          if (Navigator.canPop(context)) Navigator.pop(context);
        },
        child: Container(
          padding: EdgeInsets.all(8.r),
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: const Icon(Icons.arrow_back_ios_new, size: 20),
        ),
      ),
    );
  }
}
