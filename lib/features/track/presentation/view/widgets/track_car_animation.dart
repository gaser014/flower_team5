import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class TrackCarAnimation extends StatelessWidget {
  const TrackCarAnimation({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 180.h,
        child: Lottie.asset('assets/json/carpool.json'),
      ),
    );
  }
}
