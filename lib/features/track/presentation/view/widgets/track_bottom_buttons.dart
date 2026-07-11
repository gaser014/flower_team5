import 'package:flowers_app/core/routes/routes.dart';
import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/core/values/app_font_style.dart';
import 'package:flowers_app/core/values/app_strings.dart';
import 'package:flowers_app/features/track/domain/entities/track_order_entity.dart';
import 'package:flowers_app/features/track/presentation/view_model/cubit/track_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

/// Bottom actions for the track screen.
///
/// While the order is in progress only "Show Map" is shown. Once the driver
/// **arrives**, the customer gets a "Confirm Delivery" button — the only place
/// an order can be moved to **delivered**. After that it becomes a disabled
/// confirmation.
class TrackBottomButtons extends StatelessWidget {
  final TrackOrderStatus status;

  const TrackBottomButtons({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    final canConfirm = status == TrackOrderStatus.arrived;
    final isDelivered = status.isDelivered;

    if (!canConfirm && !isDelivered) {
      return const _ShowMapButton(fullWidth: true);
    }

    return Row(
      children: [
        const Expanded(child: _ShowMapButton()),
        Gap(10.w),
        Expanded(
          child: isDelivered
              ? const _DeliveredButton()
              : const _ConfirmDeliveryButton(),
        ),
      ],
    );
  }
}

class _ShowMapButton extends StatelessWidget {
  final bool fullWidth;

  const _ShowMapButton({this.fullWidth = false});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: fullWidth ? double.infinity : null,
      height: 50.h,
      child: ElevatedButton(
        onPressed: () =>
            context.push(Routes.trackMap, extra: context.read<TrackCubit>()),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primerColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        child: Text(
          AppStrings.showMap,
          style: AppFontStyle.bold16().copyWith(color: Colors.white),
        ),
      ),
    );
  }
}

class _ConfirmDeliveryButton extends StatelessWidget {
  const _ConfirmDeliveryButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TrackCubit, TrackStates>(
      buildWhen: (p, c) => p.deliverState != c.deliverState,
      builder: (context, state) {
        final isLoading = state.deliverState.isLoading;
        return SizedBox(
          height: 50.h,
          child: ElevatedButton(
            onPressed: isLoading
                ? null
                : () => context.read<TrackCubit>().doIntent(
                    const MarkDeliveredEvent(),
                  ),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primerColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
            ),
            child: isLoading
                ? SizedBox(
                    height: 20.h,
                    width: 20.h,
                    child: const CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : Text(
                    AppStrings.confirmDelivery,
                    style: AppFontStyle.bold16().copyWith(color: Colors.white),
                  ),
          ),
        );
      },
    );
  }
}

class _DeliveredButton extends StatelessWidget {
  const _DeliveredButton();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      child: ElevatedButton.icon(
        onPressed: null,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primerColor,
          disabledBackgroundColor: AppColors.primerColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
        ),
        icon: const Icon(Icons.check_circle, color: Colors.white, size: 20),
        label: Text(
          AppStrings.statusDelivered,
          style: AppFontStyle.bold16().copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
