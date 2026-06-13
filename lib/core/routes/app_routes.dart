import 'dart:developer';
import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flowers_app/config/dependency_injection/di.dart';
import 'package:flowers_app/core/data/data_sources/auth_local_data_source.dart';
import 'package:flowers_app/core/routes/routes.dart';
import 'package:flowers_app/features/app_filter_tabs/domain/entities/app_filter_tab_item_entity.dart';
import 'package:flowers_app/features/best_seller/presentation/view/pages/best_seller_page.dart';
import 'package:flowers_app/features/edit_profile/presentation/view/pages/change_password_page.dart';
import 'package:flowers_app/features/edit_profile/presentation/view/pages/edit_profile_page.dart';
import 'package:flowers_app/features/forget_password/presentation/view_model/bloc/forget_password_bloc.dart';
import 'package:flowers_app/features/login/presentation/view/pages/login_page.dart';
import 'package:flowers_app/features/main/presentation/screens/main_view.dart';
import 'package:flowers_app/features/notifications/presentation/view/pages/notifications_page.dart';
import 'package:flowers_app/features/products/presentation/view/pages/occasion_page.dart';
import 'package:flowers_app/features/spalsh/splash_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:flowers_app/features/auth/sign_up/presentation/screens/sign_up_view.dart';
import 'package:flowers_app/features/auth/sign_up/presentation/screens/terms_and_conditions_view.dart';

import '../../features/forget_password/presentation/view/pages/forget_password_page.dart';
import '../../features/forget_password/presentation/view/pages/verify_code_page.dart';
import '../../features/forget_password/presentation/view/pages/reset_password_page.dart';
import 'package:flowers_app/features/products/domain/entities/product_entity.dart';

final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();

// Animation Type Enum
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

// Custom Page Builder with Animation Support
Page<T> buildAnimatedPage<T extends Object?>({
  required Widget child,
  required LocalKey key,
  AnimationType animationType = AnimationType.fade,
  Duration duration = const Duration(milliseconds: 300),
  Curve curve = Curves.easeInOut,
}) {
  // Use Cupertino page for iOS
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

// Animation Builder Function
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

// Enhanced Custom Transition Page
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
        path: Routes.forgetPassword,
        name: Routes.forgetPassword,
        builder: (BuildContext context, GoRouterState state) {
          return const ForgetPasswordPage();
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
          final product = state.extra as ProductEntity;
          return buildAnimatedPage(
            key: state.pageKey,
            child: ProductDetailsPage(product: product),
            animationType: AnimationType.fade,
          );
        },
      ),
      GoRoute(
        path: Routes.profile,
        name: Routes.profile,
        builder: (BuildContext context, GoRouterState state) {
          return const ProfilePage();
        },
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
        path: Routes.verifyCode,
        name: Routes.verifyCode,
        builder: (BuildContext context, GoRouterState state) {
          final cubit =
              state.extra as ForgetPasswordBloc? ?? getIt<ForgetPasswordBloc>();
          return VerifyCodePage(bloc: cubit);
        },
      ),
      GoRoute(
        path: Routes.resetPassword,
        name: Routes.resetPassword,
        builder: (BuildContext context, GoRouterState state) {
          final cubit =
              state.extra as ForgetPasswordBloc? ?? getIt<ForgetPasswordBloc>();
          return ResetPasswordPage(bloc: cubit);
        },
      ),
      GoRoute(
        path: Routes.register,
        pageBuilder: (context, state) => buildAnimatedPage(
          key: state.pageKey,
          child: const SignUpView(),
          animationType: AnimationType.slideFromRight,
        ),
      ),
      GoRoute(
        path: Routes.editProfile,
        name: Routes.editProfile,
        builder: (BuildContext context, GoRouterState state) {
          return const EditProfilePage();
        },
      ),
      GoRoute(
        path: Routes.changePassword,
        name: Routes.changePassword,
        builder: (BuildContext context, GoRouterState state) {
          return const ChangePasswordPage();
        },
      ),
      GoRoute(
        path: Routes.termsAndConditions,
        pageBuilder: (context, state) => buildAnimatedPage(
          key: state.pageKey,
          child: const TermsAndConditionsView(),
          animationType: AnimationType.slideFromRight,
        ),
      ),
      GoRoute(
        path: Routes.main,
        name: Routes.main,
        pageBuilder: (context, state) => buildAnimatedPage(
          key: state.pageKey,
          child: KeyedSubtree(
            key: ValueKey(context.locale),
            child: const MainView(),
          ),
          animationType: AnimationType.fade,
        ),
      ),
      GoRoute(
        path: Routes.login,
        name: Routes.login,
        builder: (BuildContext context, GoRouterState state) {
          return LoginPage();
        },
      ),
      GoRoute(
        path: Routes.notifications,
        name: Routes.notifications,
        builder: (BuildContext context, GoRouterState state) {
          return NotificationsPage();
        },
      ),
    ],
    redirect: (context, state) async {
      final currentLocation = state.matchedLocation;

      final authRoutes = [
        Routes.login,
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
        log('Auth Token: $token');
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
