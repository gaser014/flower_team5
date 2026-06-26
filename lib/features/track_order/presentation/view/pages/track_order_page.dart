import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flowers_app/config/dependency_injection/di.dart';
import 'package:flowers_app/core/routes/routes.dart';
import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/core/values/app_font_style.dart';
import 'package:flowers_app/core/values/app_strings.dart';
import 'package:flowers_app/core/widgets/custom_app_bar.dart';
import 'package:flowers_app/core/widgets/loading_indicator.dart';
import 'package:flowers_app/features/track_order/domain/entities/track_order_entity.dart';
import 'package:flowers_app/features/track_order/presentation/view/pages/track_order_map_page.dart';
import 'package:flowers_app/features/track_order/presentation/view/widgets/track_order_body.dart';
import 'package:flowers_app/features/track_order/presentation/view/widgets/track_order_bottom_bar.dart';
import 'package:flowers_app/features/track_order/presentation/view_model/cubit/track_order_cubit.dart';
import 'package:go_router/go_router.dart';

class TrackOrderPage extends StatelessWidget {
  const TrackOrderPage({super.key, required this.orderId});

  final String orderId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          getIt<TrackOrderCubit>()..doIntent(StartTrackingEvent(orderId)),
      child: Scaffold(
        backgroundColor: AppColors.whiteF9,
        appBar: CustomAppBar(title: AppStrings.trackOrder),
        body: SafeArea(
          child: BlocBuilder<TrackOrderCubit, TrackOrderStates>(
            builder: (context, state) => state.trackState.when(
              initial: () => const CenteredLoadingIndicator(),
              loading: () => const CenteredLoadingIndicator(),
              success: (order) => _TrackOrderContent(order: order),
              error: (_) => const _ErrorView(),
            ),
          ),
        ),
      ),
    );
  }
}

class _TrackOrderContent extends StatelessWidget {
  const _TrackOrderContent({required this.order});

  final TrackOrderEntity order;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: TrackOrderBody(order: order)),
        if (order.status.showDeliveryActions)
          TrackOrderBottomBar(onShowMap: () => _openMap(context)),
      ],
    );
  }

  void _openMap(BuildContext context) {
    context.pushNamed(
      Routes.trackOrderMap,
      extra: TrackOrderMapArgs(lat: order.driverLat, lng: order.driverLng),
    );
  }
}

class _ErrorView extends StatelessWidget {
  const _ErrorView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Text(
          AppStrings.orderNotFound,
          textAlign: TextAlign.center,
          style: AppFontStyle.regular16(
            context: context,
          ).copyWith(color: AppColors.gray53),
        ),
      ),
    );
  }
}
