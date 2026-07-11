import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

extension OrderTrackingConstants on BuildContext {
  String get trackOrderTitle => 'order_tracking.title'.tr();
  String get trackOrder => 'order_tracking.track_order'.tr();
  String get estimatedArrival => 'order_tracking.estimated_arrival'.tr();
  String get deliveryHero => 'order_tracking.delivery_hero'.tr();
  String get orderDetailsButton => 'order_tracking.order_details'.tr();
  String get calculatingArrival => 'order_tracking.calculating'.tr();
  String get trackRouteUnavailable => 'order_tracking.route_unavailable'.tr();
  String get floweryLabel => 'order_tracking.flowery'.tr();
  String get yourLocationLabel => 'order_tracking.your_location'.tr();
  String get yourDriver => 'order_tracking.your_driver'.tr();
  String get waitingForDriver => 'order_tracking.waiting_for_driver'.tr();
  String get driverArrivedTitle => 'order_tracking.driver_arrived_title'.tr();
  String get driverArrivedMessage =>
      'order_tracking.driver_arrived_message'.tr();
  String get arrivedLabel => 'order_tracking.arrived'.tr();
  String get gotIt => 'order_tracking.got_it'.tr();
}
