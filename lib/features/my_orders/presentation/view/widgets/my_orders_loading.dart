import 'package:flutter/material.dart';

class MyOrdersLoading extends StatelessWidget {
  const MyOrdersLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}
