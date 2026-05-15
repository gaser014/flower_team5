import 'package:flowers_app/config/dependency_injection/di.dart';
import 'package:flowers_app/core/values/app_strings.dart';
import 'package:flowers_app/core/widgets/custom_app_bar.dart';
import 'package:flowers_app/features/best_seller/presentation/view_model/cubit/best_seller_cubit.dart';
import 'package:flowers_app/features/best_seller/presentation/view/widgets/best_seller_body.dart';
import 'package:flowers_app/features/best_seller/presentation/view_model/cubit/best_seller_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BestSellerPage extends StatelessWidget {
  const BestSellerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt<BestSellerCubit>()..onEvent(GetBestSellersEvent()),
      child: Scaffold(
        appBar: CustomAppBar(
          title: AppStrings.bestSeller,
          subTitle: AppStrings.bestSellerSubtitle,
        ),
        body: SafeArea(child: const BestSellerBody()),
      ),
    );
  }
}
