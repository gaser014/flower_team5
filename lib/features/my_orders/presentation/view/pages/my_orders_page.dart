import 'package:flowers_app/core/values/app_font_style.dart';
import 'package:flowers_app/core/values/app_strings.dart';
import 'package:flowers_app/features/my_orders/presentation/view/widgets/my_orders_body.dart';
import 'package:flutter/material.dart';

class MyOrdersPage extends StatelessWidget {
  const MyOrdersPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          AppStrings.myOrders,
          style: AppFontStyle.semiBold18(context: context),
        ),
      ),
      body: MyOrdersPageBody(),
    );
  }
}
