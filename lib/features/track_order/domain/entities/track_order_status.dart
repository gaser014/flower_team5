import 'package:flutter/material.dart';
import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/core/values/app_strings.dart';

enum TrackOrderStatus {
  placed(label: AppStrings.orderPlacedSuccessfully, step: 1),
  preparing(label: AppStrings.preparingYourOrder, step: 2),
  outForDelivery(label: AppStrings.outForDelivery, step: 3),
  delivered(label: AppStrings.orderDelivered, step: 4),
  cancelled(label: AppStrings.orderCancelled, step: 0);

  const TrackOrderStatus({required this.label, required this.step});

  final String label;
  final int step;

  static const int totalSteps = 4;

  bool get isCancelled => this == TrackOrderStatus.cancelled;

  bool get showDeliveryActions => this == TrackOrderStatus.outForDelivery;

  Color get color => isCancelled ? AppColors.redCC : AppColors.green0C;

  IconData get icon => isCancelled ? Icons.close_rounded : Icons.check_rounded;

  static TrackOrderStatus fromStatusString(String? raw) {
    final value = raw?.trim().toLowerCase().replaceAll(RegExp(r'[\s_-]'), '');
    switch (value) {
      case 'pending':
      case 'placed':
      case 'new':
      case 'created':
        return TrackOrderStatus.placed;
      case 'accepted':
      case 'preparing':
      case 'processing':
      case 'picked':
      case 'inprogress':
        return TrackOrderStatus.preparing;
      case 'arrived':
      case 'outfordelivery':
      case 'ondelivery':
      case 'ontheway':
      case 'shipping':
      case 'shipped':
        return TrackOrderStatus.outForDelivery;
      case 'delivered':
      case 'completed':
      case 'done':
        return TrackOrderStatus.delivered;
      case 'cancelled':
      case 'canceled':
      case 'rejected':
        return TrackOrderStatus.cancelled;
      default:
        return TrackOrderStatus.placed;
    }
  }
}
