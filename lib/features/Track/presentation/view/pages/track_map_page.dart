import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:track_flowers_app/core/values/app_colors.dart';
import 'package:track_flowers_app/core/values/app_font_style.dart';
import 'package:track_flowers_app/core/values/app_strings.dart';

class TrackMapPage extends StatefulWidget {
  const TrackMapPage({super.key});

  @override
  State<TrackMapPage> createState() => _TrackMapPageState();
}

class _TrackMapPageState extends State<TrackMapPage> with SingleTickerProviderStateMixin {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const LatLng sourceLocation = LatLng(37.422131, -122.084801);
  static const LatLng destLocation = LatLng(37.42796133580664, -122.085749655962);

  LatLng _currentLocation = sourceLocation;
  late AnimationController _animationController;
  late Animation<double> _animation;

  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};

  @override
  void initState() {
    super.initState();
    _setMapPins();
    _startAnimation();
  }

  void _setMapPins() {
    _markers.add(
      const Marker(
        markerId: MarkerId('sourcePin'),
        position: sourceLocation,
      ),
    );
    _markers.add(
      const Marker(
        markerId: MarkerId('destPin'),
        position: destLocation,
      ),
    );
    _polylines.add(
      const Polyline(
        polylineId: PolylineId('route'),
        color: AppColors.primerColor,
        width: 5,
        points: [sourceLocation, destLocation],
      ),
    );
  }

  void _startAnimation() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    );
    
    _animation = Tween<double>(begin: 0, end: 1).animate(_animationController)
      ..addListener(() {
        final double t = _animation.value;
        final double lat = sourceLocation.latitude + (destLocation.latitude - sourceLocation.latitude) * t;
        final double lng = sourceLocation.longitude + (destLocation.longitude - sourceLocation.longitude) * t;
        
        setState(() {
          _currentLocation = LatLng(lat, lng);
          _updateMotorcycleMarker();
        });
      });

    _animationController.repeat(reverse: true);
    _updateMotorcycleMarker();
  }

  void _updateMotorcycleMarker() {
    _markers.removeWhere((marker) => marker.markerId.value == 'motorcycle');
    _markers.add(
      Marker(
        markerId: const MarkerId('motorcycle'),
        position: _currentLocation,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  static const CameraPosition _initialCameraPosition = CameraPosition(
    target: LatLng(37.425, -122.085),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteF9,
      body: Stack(
        children: [
          // Map
          GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: _initialCameraPosition,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            markers: _markers,
            polylines: _polylines,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
          ),
          
          // Back button
          Positioned(
            top: 50.h,
            left: 20.w,
            child: InkWell(
              onTap: () {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
              },
              child: Container(
                padding: EdgeInsets.all(8.r),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.arrow_back_ios_new, size: 20),
              ),
            ),
          ),

          // Bottom card
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.r),
                  topRight: Radius.circular(20.r),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.estimatedArrival,
                    style: AppFontStyle.medium14().copyWith(color: AppColors.black85),
                  ),
                  Gap(5.h),
                  Text('03 Sep 2024, 11:00 AM', style: AppFontStyle.bold16()),
                  Gap(20.h),
                  // Driver info card
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 20.r,
                        backgroundColor: AppColors.pinkF9,
                        child: Icon(
                          Icons.person,
                          color: AppColors.primerColor,
                          size: 20.r,
                        ),
                      ),
                      Gap(10.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Muhamed', style: AppFontStyle.bold14()),
                            Text(
                              AppStrings.deliveryHero,
                              style: AppFontStyle.medium12().copyWith(
                                color: AppColors.black85,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Icon(Icons.phone, color: AppColors.primerColor, size: 24.r),
                      Gap(15.w),
                      Icon(
                        Icons.chat_bubble_outline,
                        color: AppColors.primerColor,
                        size: 24.r,
                      ),
                    ],
                  ),
                  Gap(20.h),
                  // Bottom button
                  SizedBox(
                    width: double.infinity,
                    height: 50.h,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primerColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                      ),
                      child: Text(
                        AppStrings.orderDetails,
                        style: AppFontStyle.bold16().copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                  Gap(MediaQuery.of(context).padding.bottom),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
