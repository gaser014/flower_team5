import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/core/values/app_font_style.dart';
import 'package:flowers_app/features/track/presentation/view/widgets/track_content.dart';
import 'package:flowers_app/features/track/presentation/view_model/cubit/track_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// Listens to [TrackCubit] and renders the correct state. The success view
/// updates live as new order snapshots arrive from Firebase.
class TrackBody extends StatelessWidget {
  const TrackBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: BlocBuilder<TrackCubit, TrackStates>(
        buildWhen: (previous, current) =>
            previous.orderState != current.orderState,
        builder: (context, state) {
          return state.orderState.when(
            initial: () =>
                const Center(child: CircularProgressIndicator.adaptive()),
            loading: () =>
                const Center(child: CircularProgressIndicator.adaptive()),
            success: (order) => TrackContent(order: order),
            error: (exception) => _TrackError(message: exception.toString()),
          );
        },
      ),
    );
  }
}

class _TrackError extends StatelessWidget {
  final String message;

  const _TrackError({required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(24.w),
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: AppFontStyle.medium14().copyWith(color: AppColors.black85),
        ),
      ),
    );
  }
}
