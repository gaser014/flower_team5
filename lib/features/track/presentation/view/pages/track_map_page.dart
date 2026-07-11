import 'dart:async';

import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/features/track/domain/entities/track_lat_lng_entity.dart';
import 'package:flowers_app/features/track/domain/entities/track_order_entity.dart';
import 'package:flowers_app/features/track/presentation/view/widgets/track_map_back_button.dart';
import 'package:flowers_app/features/track/presentation/view/widgets/track_map_bottom_card.dart';
import 'package:flowers_app/features/track/presentation/view_model/cubit/track_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// Full-screen live map. The driver marker and route are rebuilt from every
/// [TrackCubit] snapshot, so the customer sees the driver move in real time.
class TrackMapPage extends StatefulWidget {
  const TrackMapPage({super.key});

  @override
  State<TrackMapPage> createState() => _TrackMapPageState();
}

class _TrackMapPageState extends State<TrackMapPage> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static const CameraPosition _fallbackCamera = CameraPosition(
    target: LatLng(30.9456534, 31.2922893),
    zoom: 13,
  );

  LatLng? _lastCameraTarget;

  LatLng _toLatLng(TrackLatLngEntity e) => LatLng(e.lat, e.lng);

  Set<Marker> _buildMarkers(TrackOrderEntity order) {
    final markers = <Marker>{};
    final store = order.storeLocation;
    final customer = order.customerLocation;
    final driver = order.driverLocation;

    if (store != null) {
      markers.add(
        Marker(
          markerId: const MarkerId('store'),
          position: _toLatLng(store),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
          infoWindow: InfoWindow(title: order.store.name),
        ),
      );
    }
    if (customer != null) {
      markers.add(
        Marker(
          markerId: const MarkerId('customer'),
          position: _toLatLng(customer),
        ),
      );
    }
    if (driver != null) {
      markers.add(
        Marker(
          markerId: const MarkerId('driver'),
          position: _toLatLng(driver),
          icon: BitmapDescriptor.defaultMarkerWithHue(
            BitmapDescriptor.hueAzure,
          ),
        ),
      );
    }
    return markers;
  }

  Set<Polyline> _buildPolylines(TrackOrderEntity order) {
    final points = <LatLng>[
      if (order.driverLocation != null) _toLatLng(order.driverLocation!),
      if (order.customerLocation != null) _toLatLng(order.customerLocation!),
    ];
    if (points.length < 2) return {};
    return {
      Polyline(
        polylineId: const PolylineId('route'),
        color: AppColors.primerColor,
        width: 5,
        points: points,
      ),
    };
  }

  Future<void> _followDriver(TrackOrderEntity order) async {
    final target =
        order.driverLocation ?? order.customerLocation ?? order.storeLocation;
    if (target == null) return;
    final latLng = _toLatLng(target);
    if (_lastCameraTarget == latLng) return;
    _lastCameraTarget = latLng;
    if (!_controller.isCompleted) return;
    final controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newLatLng(latLng));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteF9,
      body: BlocConsumer<TrackCubit, TrackStates>(
        listenWhen: (p, c) => p.orderState != c.orderState,
        listener: (context, state) {
          final order = state.orderState.data;
          if (order != null) _followDriver(order);
        },
        builder: (context, state) {
          final order = state.orderState.data;
          return Stack(
            children: [
              GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: _initialCamera(order),
                onMapCreated: (controller) {
                  if (!_controller.isCompleted) {
                    _controller.complete(controller);
                  }
                  if (order != null) _followDriver(order);
                },
                markers: order == null ? {} : _buildMarkers(order),
                polylines: order == null ? {} : _buildPolylines(order),
                myLocationEnabled: true,
                myLocationButtonEnabled: false,
                zoomControlsEnabled: false,
              ),
              const TrackMapBackButton(),
              if (order != null) TrackMapBottomCard(order: order),
            ],
          );
        },
      ),
    );
  }

  CameraPosition _initialCamera(TrackOrderEntity? order) {
    final target =
        order?.driverLocation ??
        order?.storeLocation ??
        order?.customerLocation;
    if (target == null) return _fallbackCamera;
    return CameraPosition(target: _toLatLng(target), zoom: 14);
  }
}
