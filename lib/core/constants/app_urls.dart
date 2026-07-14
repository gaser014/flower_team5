import 'package:flutter/material.dart';

abstract class AppUrls {
  static final Uri aboutUs = Uri.parse(
    'https://elevate-flutter-team.github.io/flower_app_web_views/about.html',
  );

  static final Uri termsAndConditions = Uri.parse(
    'https://elevate-flutter-team.github.io/flower_app_web_views/terms.html',
  );

  static Future<void> openUrl(BuildContext context, Uri url) async {
    if (!await canLaunchUrl(url) ||
        !await launchUrl(url, mode: LaunchMode.platformDefault)) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Unable to open the page.')),
      );
    }
  }
}
