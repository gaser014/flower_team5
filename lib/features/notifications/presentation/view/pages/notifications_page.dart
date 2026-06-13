import 'package:flowers_app/core/values/app_assets.dart';
import 'package:flowers_app/core/values/app_font_style.dart';
import 'package:flowers_app/core/values/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.notification), centerTitle: true),
      body: ListView.separated(
        itemCount: 10,
        separatorBuilder: (context, index) {
          return const Divider();
        },
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('New offer', style: AppFontStyle.semiBold18()),
            subtitle: Text(
              'Lorem ipsum dolor sit amet consectetur. Tristique et mauris sem congue in felis id nec. Amet sed morbi bibendum vestibulum.',
            ),
            leading: SvgPicture.asset(AppAssets.iconsNotification),
          );
        },
      ),
    );
  }
}
