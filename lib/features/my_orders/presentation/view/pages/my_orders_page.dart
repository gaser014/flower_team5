import 'package:flowers_app/config/dependency_injection/di.dart';
import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/core/values/app_strings.dart';
import 'package:flowers_app/core/widgets/custom_app_bar.dart';
import 'package:flowers_app/features/my_orders/presentation/view/widgets/my_orders_body.dart';
import 'package:flowers_app/features/my_orders/presentation/view/widgets/my_orders_header.dart';
import 'package:flowers_app/features/my_orders/presentation/view_model/cubit/my_orders_cubit.dart';
import 'package:flowers_app/features/my_orders/presentation/view_model/cubit/my_orders_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyOrdersPage extends StatelessWidget {
  const MyOrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<MyOrdersCubit>()..doIntent(GetOrdersEvent()),
      child: Scaffold(
        backgroundColor: AppColors.whiteF9,
        appBar: CustomAppBar(title: AppStrings.myOrders),
        body: SafeArea(child: MyOrdersPageBody()),
      ),
    );
  }
}
