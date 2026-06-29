import 'package:flowers_app/core/values/app_strings.dart';
import 'package:flutter/material.dart';

class TermsAndConditionsView extends StatelessWidget {
  const TermsAndConditionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text(AppStrings.termsConditionsPart2)),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Text(
            AppStrings.termsAndConditionsView,
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
