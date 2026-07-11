import 'package:flowers_app/config/dependency_injection/di.dart';
import 'package:flowers_app/core/localization_constants/order_tracking_constants.dart';
import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/core/values/app_font_style.dart';
import 'package:flowers_app/features/order_tracking/domain/entities/order_route_entity.dart';
import 'package:flowers_app/features/order_tracking/domain/entities/order_tracking_args.dart';
import 'package:flowers_app/features/order_tracking/domain/entities/tracking_order_entity.dart';
import 'package:flowers_app/features/order_tracking/domain/tracking_defaults.dart';
import 'package:flowers_app/features/order_tracking/presentation/view/widgets/driver_arrived_sheet.dart';
import 'package:flowers_app/features/order_tracking/presentation/view/widgets/order_tracking_map.dart';
import 'package:flowers_app/features/order_tracking/presentation/view/widgets/tracking_bottom_panel.dart';
import 'package:flowers_app/features/order_tracking/presentation/view/widgets/tracking_map_back_button.dart';
import 'package:flowers_app/features/order_tracking/presentation/view_model/cubit/order_tracking_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class OrderTrackingPage extends StatelessWidget {
  const OrderTrackingPage({super.key, required this.args});

  final OrderTrackingArgs args;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OrderTrackingCubit>(
      create: (_) =>
          getIt<OrderTrackingCubit>()..doIntent(WatchOrderEvent(args)),
      child: const OrderTrackingView(),
    );
  }
}

class OrderTrackingView extends StatelessWidget {
  const OrderTrackingView({super.key});

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.of(context).padding.top;
    return Scaffold(
      backgroundColor: AppColors.whiteF9,
      body: Stack(
        children: [
          Positioned.fill(child: _buildBody()),
          Positioned(
            top: topInset + 8,
            left: 16,
            child: const TrackingMapBackButton(),
          ),
        ],
      ),
    );
  }

  Widget _buildBody() {
    return BlocConsumer<OrderTrackingCubit, OrderTrackingStates>(
      listenWhen: (p, c) => !p.hasArrived && c.hasArrived,
      listener: (context, state) => showDriverArrivedSheet(context),
      buildWhen: (p, c) =>
          p.orderState != c.orderState ||
          p.route != c.route ||
          p.driverLocation != c.driverLocation ||
          p.hasArrived != c.hasArrived,
      builder: (context, state) {
        return state.orderState.when(
          initial: _loading,
          loading: _loading,
          success: (order) => _buildSuccess(context, state, order),
          error: (_) => const _TrackingError(),
        );
      },
    );
  }

  Widget _loading() => const _TrackingLoading();

  Widget _buildSuccess(
    BuildContext context,
    OrderTrackingStates state,
    TrackingOrderEntity order,
  ) {
    final route = state.route ?? _routeFromOrder(order);
    if (route == null) return const _TrackingError();

    return Stack(
      children: [
        Positioned.fill(
          child: OrderTrackingMap(
            route: route,
            driverLocation: state.driverLocation ?? order.driverLocation,
            storeLabel: order.storeName.isNotEmpty
                ? order.storeName
                : context.floweryLabel,
            userLabel: context.yourLocationLabel,
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: TrackingBottomPanel(
            hasDriver: order.hasDriver,
            hasArrived: state.hasArrived,
            driverName: order.driverName,
            driverPhoto: order.driverPhoto,
            estimatedArrival: order.estimatedArrival,
            durationText: route.durationText,
            onOrderDetails: () => context.pop(),
          ),
        ),
      ],
    );
  }

  OrderRouteEntity? _routeFromOrder(TrackingOrderEntity order) {
    if (order.userLocation == null) return null;
    return OrderRouteEntity(
      storeLocation: order.storeLocation ?? TrackingDefaults.storeLocation,
      userLocation: order.userLocation,
    );
  }
}

class _TrackingLoading extends StatelessWidget {
  const _TrackingLoading();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.lightGray,
      alignment: Alignment.center,
      child: const CircularProgressIndicator(color: AppColors.primerColor),
    );
  }
}

class _TrackingError extends StatelessWidget {
  const _TrackingError();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.lightGray,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Text(
        context.trackRouteUnavailable,
        textAlign: TextAlign.center,
        style: AppFontStyle.regular14(
          context: context,
        ).copyWith(color: AppColors.gray53),
      ),
    );
  }
}
