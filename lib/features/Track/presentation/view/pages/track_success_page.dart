import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:track_flowers_app/core/values/app_colors.dart';
import 'package:track_flowers_app/core/values/app_font_style.dart';

class TrackSuccessPage extends StatefulWidget {
  const TrackSuccessPage({super.key});

  @override
  State<TrackSuccessPage> createState() => _TrackSuccessPageState();
}

class _TrackSuccessPageState extends State<TrackSuccessPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat(reverse: true);
    _animation = Tween<double>(
      begin: 1.0,
      end: 1.3,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteF9,
      appBar: AppBar(
        title: Text('Track order', style: AppFontStyle.bold18()),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          },
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(flex: 2),
              AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      Transform.scale(
                        scale: _animation.value * 1.5,
                        child: Container(
                          width: 100.w,
                          height: 100.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.green0C.withOpacity(0.1),
                          ),
                        ),
                      ),
                      Transform.scale(
                        scale: _animation.value * 1.25,
                        child: Container(
                          width: 100.w,
                          height: 100.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.green0C.withOpacity(0.2),
                          ),
                        ),
                      ),
                      Container(
                        width: 100.w,
                        height: 100.w,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.green0C,
                        ),
                        child: Icon(
                          Icons.check,
                          color: AppColors.white,
                          size: 50.w,
                        ),
                      ),
                    ],
                  );
                },
              ),
              Gap(40.h),
              Text(
                'Your order placed\nsuccessfully!',
                style: AppFontStyle.bold20().copyWith(color: AppColors.black0C),
                textAlign: TextAlign.center,
              ),
              const Spacer(flex: 3),
              SizedBox(
                width: double.infinity,
                height: 50.h,
                child: ElevatedButton(
                  onPressed: () {
                    context.replace('/track');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primerColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  child: Text(
                    'Track order',
                    style: AppFontStyle.bold16().copyWith(color: Colors.white),
                  ),
                ),
              ),
              Gap(20.h),
            ],
          ),
        ),
      ),
    );
  }
}
