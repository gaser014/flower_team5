import 'package:easy_localization/easy_localization.dart';
import 'package:flowers_app/config/dependency_injection/di.dart';
import 'package:flowers_app/core/routes/app_routes.dart';
import 'package:flowers_app/core/theme/app_theme.dart';
import 'package:flowers_app/features/cart/presentation/view_model/cubit/cart_cubit.dart';
import 'package:flowers_app/features/location/presentation/cubit/location_cubit.dart';
import 'package:flowers_app/features/main/presentation/view_model/cubit/home_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => getIt.get<HomeCubit>()),
            BlocProvider<CartCubit>(create: (_) => getIt<CartCubit>()),
            BlocProvider<LocationCubit>(
              create: (_) => getIt<LocationCubit>()..initializeHomeLocation(),
            ),
          ],
          child: MaterialApp.router(
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            title: "Flowers App",
            routerConfig: AppRoutes.router,
            builder: (context, child) {
              final mediaQuery = MediaQuery.of(context);
              return MediaQuery(
                data: mediaQuery.copyWith(
                  boldText: false,
                  textScaler: const TextScaler.linear(1),
                ),
                child: child!,
              );
            },
            debugShowCheckedModeBanner: false,
            themeMode: ThemeMode.light,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
          ),
        );
      },
    );
  }
}
