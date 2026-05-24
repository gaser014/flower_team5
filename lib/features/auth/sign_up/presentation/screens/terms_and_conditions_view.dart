import 'package:flowers_app/core/values/app_strings.dart';
import 'package:flutter/material.dart';

class TermsAndConditionsView extends StatelessWidget {
  const TermsAndConditionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.termsConditionsPart2)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Text(
            AppStrings.termsAndConditionsView,
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
