import 'dart:async';

import 'package:flowers_app/core/values/app_assets.dart';
import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/features/order_tracking/domain/entities/lat_lng_entity.dart';
import 'package:flowers_app/features/order_tracking/domain/entities/order_route_entity.dart';
import 'package:flowers_app/features/order_tracking/presentation/view/widgets/map_marker_factory.dart';
import 'package:flowers_app/features/order_tracking/presentation/view/widgets/route_polyline_utils.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class OrderTrackingMap extends StatefulWidget {
  const OrderTrackingMap({
    super.key,
    required this.route,
    required this.driverLocation,
    required this.storeLabel,
    required this.userLabel,
  });

  final OrderRouteEntity route;

  final LatLngEntity? driverLocation;

  final String storeLabel;
  final String userLabel;

  @override
  State<OrderTrackingMap> createState() => _OrderTrackingMapState();
}

class _OrderTrackingMapState extends State<OrderTrackingMap> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  BitmapDescriptor? _driverIcon;
  BitmapDescriptor? _storeIcon;
  BitmapDescriptor? _userIcon;

  static const LatLng _fallbackTarget = LatLng(30.0444, 31.2357);

  @override
  void initState() {
    super.initState();
    _buildIcons();
  }

  Future<void> _buildIcons() async {
    final driver = await MapMarkerFactory.svgMarker(
      assetPath: AppAssets.motorcycleDelivery,
      rotationDegrees: 90,
    );
    final store = await MapMarkerFactory.pillMarker(
      label: widget.storeLabel,
      icon: Icons.local_florist,
    );
    final user = await MapMarkerFactory.pillMarker(
      label: widget.userLabel,
      icon: Icons.home,
    );
    if (!mounted) return;
    setState(() {
      _driverIcon = driver;
      _storeIcon = store;
      _userIcon = user;
    });
  }

  LatLng? get _driverLatLng {
    final d = widget.driverLocation ?? widget.route.storeLocation;
    return d == null ? null : LatLng(d.lat, d.lng);
  }

  LatLng? get _storeLatLng {
    final s = widget.route.storeLocation;
    return s == null ? null : LatLng(s.lat, s.lng);
  }

  LatLng? get _userLatLng {
    final u = widget.route.userLocation;
    return u == null ? null : LatLng(u.lat, u.lng);
  }

  double get _driverRotation {
    final polyline = widget.route.polyline;
    final driver = widget.driverLocation;
    final destination = widget.route.userLocation;

    if (driver != null && polyline.length >= 2) {
      return RoutePolylineUtils.motorcycleRotation(
        RoutePolylineUtils.headingTowardDestination(
          polyline: polyline,
          position: driver,
          destination: destination,
        ),
      );
    }

    if (destination != null && driver != null) {
      return RoutePolylineUtils.motorcycleRotation(
        RoutePolylineUtils.bearingDegrees(driver, destination),
      );
    }

    if (polyline.length >= 2) {
      return RoutePolylineUtils.motorcycleRotation(
        RoutePolylineUtils.bearingDegrees(polyline.first, polyline.last),
      );
    }

    return 0;
  }

  Set<Marker> get _markers {
    final markers = <Marker>{};
    final store = _storeLatLng;
    if (store != null) {
      markers.add(
        Marker(
          markerId: const MarkerId('store'),
          position: store,
          icon: _storeIcon ?? BitmapDescriptor.defaultMarker,
          anchor: const Offset(0.5, 0.5),
        ),
      );
    }
    final user = _userLatLng;
    if (user != null) {
      markers.add(
        Marker(
          markerId: const MarkerId('user'),
          position: user,
          icon: _userIcon ?? BitmapDescriptor.defaultMarker,
          anchor: const Offset(0.5, 0.5),
        ),
      );
    }
    final driver = widget.driverLocation;
    if (driver != null) {
      markers.add(
        Marker(
          markerId: const MarkerId('driver'),
          position: LatLng(driver.lat, driver.lng),
          icon: _driverIcon ?? BitmapDescriptor.defaultMarker,
          rotation: _driverRotation,
          flat: true,
          anchor: const Offset(0.5, 0.5),
        ),
      );
    }
    return markers;
  }

  Set<Polyline> get _polylines {
    final points = widget.route.polyline;
    if (points.length < 2) return {};

    final latLngPoints = points.map((p) => LatLng(p.lat, p.lng)).toList();
    final driver = widget.driverLocation;

    if (driver == null) {
      return {
        Polyline(
          polylineId: const PolylineId('route_remaining'),
          color: AppColors.primerColor,
          width: 4,
          points: latLngPoints,
        ),
      };
    }

    final split = RoutePolylineUtils.splitAtPosition(
      polyline: points,
      position: driver,
      destination: widget.route.userLocation,
    );
    if (split == null) {
      return {
        Polyline(
          polylineId: const PolylineId('route_remaining'),
          color: AppColors.primerColor,
          width: 4,
          points: latLngPoints,
        ),
      };
    }

    final polylines = <Polyline>{};
    final traveled = split.traveled
        .map((p) => LatLng(p.lat, p.lng))
        .toList(growable: false);
    final remaining = split.remaining
        .map((p) => LatLng(p.lat, p.lng))
        .toList(growable: false);

    if (RoutePolylineUtils.hasMeaningfulTraveledPath(split.traveled)) {
      polylines.add(
        Polyline(
          polylineId: const PolylineId('route_traveled'),
          color: AppColors.grayA6,
          width: 4,
          points: traveled,
        ),
      );
    }

    if (remaining.length >= 2) {
      polylines.add(
        Polyline(
          polylineId: const PolylineId('route_remaining'),
          color: AppColors.primerColor,
          width: 4,
          points: remaining,
        ),
      );
    }

    return polylines;
  }

  @override
  void didUpdateWidget(covariant OrderTrackingMap oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.driverLocation != widget.driverLocation) {
      _animateToDriver();
    }
  }

  Future<void> _animateToDriver() async {
    final driver = _driverLatLng;
    if (driver == null || !_controller.isCompleted) return;
    final controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newLatLng(driver));
  }

  Future<void> _fitBounds() async {
    final controller = await _controller.future;
    final points = <LatLng>[
      ?_storeLatLng,
      ?_userLatLng,
      ?_driverLatLng,
      ...widget.route.polyline.map((p) => LatLng(p.lat, p.lng)),
    ];

    if (points.isEmpty) return;
    if (points.length == 1) {
      await controller.animateCamera(
        CameraUpdate.newLatLngZoom(points.first, 15),
      );
      return;
    }

    double minLat = points.first.latitude;
    double maxLat = points.first.latitude;
    double minLng = points.first.longitude;
    double maxLng = points.first.longitude;
    for (final p in points) {
      minLat = p.latitude < minLat ? p.latitude : minLat;
      maxLat = p.latitude > maxLat ? p.latitude : maxLat;
      minLng = p.longitude < minLng ? p.longitude : minLng;
      maxLng = p.longitude > maxLng ? p.longitude : maxLng;
    }

    final bounds = LatLngBounds(
      southwest: LatLng(minLat, minLng),
      northeast: LatLng(maxLat, maxLng),
    );
    await controller.animateCamera(CameraUpdate.newLatLngBounds(bounds, 80));
  }

  @override
  Widget build(BuildContext context) {
    final target =
        _driverLatLng ?? _storeLatLng ?? _userLatLng ?? _fallbackTarget;
    return GoogleMap(
      initialCameraPosition: CameraPosition(target: target, zoom: 14),
      markers: _markers,
      polylines: _polylines,
      myLocationEnabled: false,
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
      compassEnabled: false,
      mapToolbarEnabled: false,
      onMapCreated: (controller) {
        if (!_controller.isCompleted) _controller.complete(controller);
        _fitBounds();
      },
    );
  }
}
