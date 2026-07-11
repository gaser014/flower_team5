import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/core/values/app_font_style.dart';
import 'package:flowers_app/core/values/app_strings.dart';
import 'package:flowers_app/features/track/presentation/view/widgets/track_body.dart';
import 'package:flutter/material.dart';

/// Customer order-tracking screen. The [TrackCubit] is provided by the route
/// and starts listening to the order's live status the moment it opens.
class TrackPage extends StatelessWidget {
  const TrackPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteF9,
      appBar: AppBar(
        title: Text(AppStrings.trackOrder, style: AppFontStyle.bold18()),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            if (Navigator.canPop(context)) Navigator.pop(context);
          },
        ),
      ),
      body: const SafeArea(child: TrackBody()),
    );
  }
}
