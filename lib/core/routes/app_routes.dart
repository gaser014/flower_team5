import 'dart:io';

import 'package:flowers_app/config/api/api_key.dart';
import 'package:flowers_app/config/dependency_injection/di.dart';
import 'package:flowers_app/core/routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';

import '../../features/forget_password/presentation/view/pages/forget_password_page.dart';
import '../../features/forget_password/presentation/view/pages/verify_code_page.dart';
import '../../features/forget_password/presentation/view/pages/reset_password_page.dart';
import '../../features/forget_password/presentation/view_model/cubit/forget_password_cubit.dart';

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
    initialLocation: Routes.forgetPassword,
    routes: [
      GoRoute(
        path: Routes.forgetPassword,
        name: Routes.forgetPassword,
        builder: (BuildContext context, GoRouterState state) {
          return const ForgetPasswordPage();
        },
      ),
      GoRoute(
        path: Routes.verifyCode,
        name: Routes.verifyCode,
        builder: (BuildContext context, GoRouterState state) {
          final cubit = state.extra as ForgetPasswordCubit? ?? getIt<ForgetPasswordCubit>();
          return VerifyCodePage(cubit: cubit);
        },
      ),
      GoRoute(
        path: Routes.resetPassword,
        name: Routes.resetPassword,
        builder: (BuildContext context, GoRouterState state) {
          final cubit = state.extra as ForgetPasswordCubit? ?? getIt<ForgetPasswordCubit>();
          return ResetPasswordPage(cubit: cubit);
        },
      ),
    ],
    redirect: (context, state) async {
      final currentLocation = state.matchedLocation;

      if (currentLocation == Routes.splash) {
        return null;
      }

      final token = await getIt<FlutterSecureStorage>().read(
        key: APIkeys.accessToken,
      );
      final isLoggedIn = token != null && token.isNotEmpty;
      final authRoutes = [
        // AuthRoutes.accountTypeSelection,
        // AuthRoutes.phoneNumber,
        // AuthRoutes.otpVerification,
        // AuthRoutes.completeProfile,
        // AuthRoutes.success,
      ];

      if (!isLoggedIn && !authRoutes.contains(currentLocation)) {
        // Redirect to account type selection (start of auth flow)
        // return AuthRoutes.accountTypeSelection;
      }

      if (isLoggedIn && authRoutes.contains(currentLocation)) {
        // Redirect to home screen
        // return Routes.home;
      }

      // No redirect needed
      return null;
    },
  );
}
