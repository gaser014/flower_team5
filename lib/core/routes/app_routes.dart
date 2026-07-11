import 'dart:io';

import 'package:flowers_app/config/dependency_injection/di.dart';
import 'package:flowers_app/core/data/data_sources/auth_local_data_source.dart';
import 'package:flowers_app/core/routes/routes.dart';
import 'package:flowers_app/features/addresses/domain/entities/address_entity.dart';
import 'package:flowers_app/features/addresses/presentation/cubit/addresses_cubit.dart';
import 'package:flowers_app/features/addresses/presentation/screens/addresses_page.dart';
import 'package:flowers_app/features/addresses/presentation/screens/add_address_screen.dart';
import 'package:flowers_app/features/app_filter_tabs/domain/entities/app_filter_tab_item_entity.dart';
import 'package:flowers_app/features/best_seller/presentation/view/pages/best_seller_page.dart';
import 'package:flowers_app/features/login/presentation/view/pages/login_page.dart';
import 'package:flowers_app/features/product_details/presentation/view/pages/product_details_page.dart';
import 'package:flowers_app/core/entities/product_entity.dart';
import 'package:flowers_app/features/products/presentation/view/pages/occasion_page.dart';
import 'package:flowers_app/features/spalsh/splash_page.dart';
import 'package:flowers_app/features/main/presentation/screens/main_view.dart';
import 'package:flowers_app/features/track/presentation/view/pages/track_page.dart';
import 'package:flowers_app/features/track/presentation/view/pages/track_map_page.dart';
import 'package:flowers_app/features/track/presentation/view_model/cubit/track_cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();

enum AnimationType {
  fade,
  slide,
  scale,
  rotation,
  slideFromBottom,
  slideFromTop,
  slideFromLeft,
  slideFromRight,
  cupertino,
}

Page<T> buildAnimatedPage<T extends Object?>({
  required Widget child,
  required LocalKey key,
  AnimationType animationType = AnimationType.fade,
  Duration duration = const Duration(milliseconds: 300),
  Curve curve = Curves.easeInOut,
}) {
  if (Platform.isIOS && animationType == AnimationType.cupertino) {
    return CupertinoPage<T>(key: key, child: child);
  }

  return CustomTransitionPage<T>(
    key: key,
    child: child,
    transitionDuration: duration,
    reverseTransitionDuration: duration,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return _getAnimationTransition(
        animationType,
        animation,
        secondaryAnimation,
        child,
        curve,
      );
    },
  );
}

Widget _getAnimationTransition(
  AnimationType type,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
  Curve curve,
) {
  final curvedAnimation = CurvedAnimation(parent: animation, curve: curve);

  switch (type) {
    case AnimationType.fade:
      return FadeTransition(opacity: curvedAnimation, child: child);

    case AnimationType.slide:
    case AnimationType.slideFromRight:
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(1.0, 0.0),
          end: Offset.zero,
        ).animate(curvedAnimation),
        child: child,
      );

    case AnimationType.slideFromLeft:
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(-1.0, 0.0),
          end: Offset.zero,
        ).animate(curvedAnimation),
        child: child,
      );

    case AnimationType.slideFromBottom:
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0.0, 1.0),
          end: Offset.zero,
        ).animate(curvedAnimation),
        child: child,
      );

    case AnimationType.slideFromTop:
      return SlideTransition(
        position: Tween<Offset>(
          begin: const Offset(0.0, -1.0),
          end: Offset.zero,
        ).animate(curvedAnimation),
        child: child,
      );

    case AnimationType.scale:
      return ScaleTransition(
        scale: curvedAnimation,
        child: FadeTransition(opacity: curvedAnimation, child: child),
      );

    case AnimationType.rotation:
      return RotationTransition(
        turns: curvedAnimation,
        child: FadeTransition(opacity: curvedAnimation, child: child),
      );

    case AnimationType.cupertino:
      return FadeTransition(opacity: curvedAnimation, child: child);
  }
}

class CustomTransitionPage<T> extends Page<T> {
  const CustomTransitionPage({
    required this.child,
    this.transitionDuration = const Duration(milliseconds: 300),
    this.reverseTransitionDuration = const Duration(milliseconds: 300),
    this.transitionsBuilder,
    super.key,
    super.name,
    super.arguments,
    super.restorationId,
  });

  final Widget child;
  final Duration transitionDuration;
  final Duration reverseTransitionDuration;
  final RouteTransitionsBuilder? transitionsBuilder;

  @override
  Route<T> createRoute(BuildContext context) {
    return _PageBasedPageRoute<T>(
      page: this,
      transitionsBuilder: transitionsBuilder,
    );
  }
}

class _PageBasedPageRoute<T> extends PageRoute<T> {
  _PageBasedPageRoute({
    required CustomTransitionPage<T> page,
    this.transitionsBuilder,
  }) : super(settings: page);

  CustomTransitionPage<T> get _page => settings as CustomTransitionPage<T>;
  final RouteTransitionsBuilder? transitionsBuilder;

  @override
  bool get barrierDismissible => false;

  @override
  Color? get barrierColor => null;

  @override
  String? get barrierLabel => null;

  @override
  Duration get transitionDuration => _page.transitionDuration;

  @override
  Duration get reverseTransitionDuration => _page.reverseTransitionDuration;

  @override
  bool get maintainState => true;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return _page.child;
  }

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return transitionsBuilder?.call(
          context,
          animation,
          secondaryAnimation,
          child,
        ) ??
        FadeTransition(opacity: animation, child: child);
  }
}

abstract class AppRoutes {
  static final GoRouter router = GoRouter(
    initialLocation: Routes.splash,
    routes: [
      GoRoute(
        path: Routes.main,
        pageBuilder: (context, state) => buildAnimatedPage(
          key: state.pageKey,
          child: const MainView(),
          animationType: AnimationType.fade,
        ),
      ),
      GoRoute(
        path: Routes.occasionPage,
        name: Routes.occasionPage,
        pageBuilder: (context, state) {
          final occasion = state.extra as AppFilterTabItemEntity?;
          return buildAnimatedPage(
            key: state.pageKey,
            child: OccasionPage(occasion: occasion),
            animationType: AnimationType.fade,
          );
        },
      ),
      GoRoute(
        path: Routes.addresses,
        name: Routes.addresses,
        pageBuilder: (context, state) => buildAnimatedPage(
          key: state.pageKey,
          child: BlocProvider<AddressesCubit>(
            create: (_) =>
                getIt<AddressesCubit>()..doIntent(const GetAddressesEvent()),
            child: const AddressesPage(),
          ),
          animationType: AnimationType.slideFromRight,
        ),
      ),
      GoRoute(
        path: Routes.addAddress,
        name: Routes.addAddress,
        pageBuilder: (context, state) {
          final Map<String, dynamic> extra =
              state.extra as Map<String, dynamic>;
          final editAddress = extra['editAddress'] as AddressEntity?;
          final cubit = extra['cubit'] as AddressesCubit;

          return buildAnimatedPage(
            key: state.pageKey,
            child: BlocProvider.value(
              value: cubit,
              child: AddAddressScreen(editAddress: editAddress),
            ),
            animationType: AnimationType.slideFromRight,
          );
        },
      ),
      GoRoute(
        path: Routes.splash,
        name: Routes.splash,
        builder: (BuildContext context, GoRouterState state) {
          return SplashPage();
        },
      ),
      GoRoute(
        path: Routes.login,
        name: Routes.login,
        builder: (BuildContext context, GoRouterState state) {
          return LoginPage();
        },
      ),
      GoRoute(
        path: Routes.bestSeller,
        name: Routes.bestSeller,
        pageBuilder: (context, state) => buildAnimatedPage(
          key: state.pageKey,
          child: const BestSellerPage(),
          animationType: AnimationType.slideFromRight,
        ),
      ),
      GoRoute(
        path: Routes.productDetails,
        name: Routes.productDetails,
        pageBuilder: (context, state) {
          final product = state.extra as ProductEntity?;
          return buildAnimatedPage(
            key: state.pageKey,
            child: ProductDetailsPage(product: product),
            animationType: AnimationType.fade,
          );
        },
      ),
      GoRoute(
        path: Routes.track,
        name: Routes.track,
        pageBuilder: (context, state) {
          final orderId = state.extra is String ? state.extra as String : '';
          return buildAnimatedPage(
            key: state.pageKey,
            child: BlocProvider<TrackCubit>(
              create: (_) => getIt<TrackCubit>()
                ..doIntent(
                  orderId.isEmpty
                      ? const ResumeTrackingEvent()
                      : StartTrackingEvent(orderId: orderId),
                ),
              child: const TrackPage(),
            ),
            animationType: AnimationType.slideFromRight,
          );
        },
      ),
      GoRoute(
        path: Routes.trackMap,
        name: Routes.trackMap,
        pageBuilder: (context, state) {
          final existingCubit = state.extra is TrackCubit
              ? state.extra as TrackCubit
              : null;
          final child = existingCubit != null
              ? BlocProvider<TrackCubit>.value(
                  value: existingCubit,
                  child: const TrackMapPage(),
                )
              : BlocProvider<TrackCubit>(
                  create: (_) =>
                      getIt<TrackCubit>()
                        ..doIntent(const ResumeTrackingEvent()),
                  child: const TrackMapPage(),
                );
          return buildAnimatedPage(
            key: state.pageKey,
            child: child,
            animationType: AnimationType.slideFromBottom,
          );
        },
      ),
    ],
    redirect: (context, state) async {
      final currentLocation = state.matchedLocation;

      final authRoutes = [
        Routes.login,
        Routes.main,
        // Routes.register,
        // Routes.forgetPassword,
        // Routes.resetPassword,
        // AuthRoutes.otpVerification,
        // AuthRoutes.completeProfile,
        // AuthRoutes.success,
      ];
      //
      // if (!isLoggedIn && !authRoutes.contains(currentLocation)) {
      //   // Redirect to account type selection (start of auth flow)
      //   return Routes.login;
      // }

      if (authRoutes.contains(currentLocation)) {
        final token = await getIt<AuthLocalDataSourceContract>().getUserToken();
        final isLoggedIn = token != null && token.isNotEmpty;

        // Redirect to home screen
        if (isLoggedIn) {
          return Routes.main;
        }
      }

      // No redirect needed
      return null;
    },
  );
}
