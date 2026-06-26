import 'package:flutter/material.dart';
import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/core/values/app_font_style.dart';
import 'package:flowers_app/core/values/app_strings.dart';
import 'package:flowers_app/core/widgets/custom_app_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TrackOrderMapArgs {
  final double? lat;
  final double? lng;

  const TrackOrderMapArgs({this.lat, this.lng});
}

class TrackOrderMapPage extends StatelessWidget {
  const TrackOrderMapPage({super.key, required this.args});

  final TrackOrderMapArgs args;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteF9,
      appBar: CustomAppBar(title: AppStrings.driverLocation),
      body: SafeArea(
        child: (args.lat == null || args.lng == null)
            ? _EmptyLocation()
            : _DriverMap(lat: args.lat!, lng: args.lng!),
      ),
    );
  }
}

class _DriverMap extends StatelessWidget {
  const _DriverMap({required this.lat, required this.lng});

  final double lat;
  final double lng;

  @override
  Widget build(BuildContext context) {
    final position = LatLng(lat, lng);
    return GoogleMap(
      initialCameraPosition: CameraPosition(target: position, zoom: 15),
      markers: {
        Marker(markerId: const MarkerId('driver'), position: position),
      },
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
    );
  }
}

class _EmptyLocation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Text(
          AppStrings.locationNotAvailableYet,
          textAlign: TextAlign.center,
          style: AppFontStyle.regular16(
            context: context,
          ).copyWith(color: AppColors.gray53),
        ),
      ),
    );
  }
}
