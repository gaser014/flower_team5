import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import 'package:flowers_app/core/values/app_colors.dart';

class MapPreview extends StatelessWidget {
  final LatLng? latLng;
  final VoidCallback onTap;

  const MapPreview({super.key, required this.latLng, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 180,
        decoration: BoxDecoration(
          color: AppColors.lightGray,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.grayEA),
        ),
        clipBehavior: Clip.antiAlias,
        child: latLng != null ? _buildMap(context) : _buildEmptyState(context),
      ),
    );
  }

  Widget _buildMap(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        initialCenter: latLng!,
        interactionOptions: const InteractionOptions(
          flags: InteractiveFlag.none,
        ),
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.flowers_app',
        ),
        MarkerLayer(
          markers: [
            Marker(
              point: latLng!,
              child: const Icon(
                Icons.location_on,
                color: AppColors.primerColor,
                size: 36,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.location_on, size: 48, color: AppColors.primerColor),
          const SizedBox(height: 8),
          Text(
            'Tap to select location',
            style: TextStyle(
              fontSize: 12,
              color: Theme.of(context).disabledColor,
            ),
          ),
        ],
      ),
    );
  }
}
