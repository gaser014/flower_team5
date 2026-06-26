import 'package:flowers_app/core/values/app_strings.dart';
import 'package:flowers_app/features/track_order/data/models/track_order_model.dart';
import 'package:flowers_app/features/track_order/domain/entities/track_order_entity.dart';
import 'package:flowers_app/features/track_order/domain/entities/track_order_item_entity.dart';
import 'package:flowers_app/features/track_order/domain/entities/track_order_status.dart';

extension TrackOrderModelMapper on TrackOrderModel {
  TrackOrderEntity toEntity() {
    final mappedItems = items
        .map((item) => item.toEntity())
        .toList(growable: false);
    final computedSubTotal = subTotal ?? _sumItems(mappedItems);
    final computedDeliveryFee =
        deliveryFee ?? _nonNegative(total - computedSubTotal);

    return TrackOrderEntity(
      id: id,
      orderNumber: orderNumber,
      status: TrackOrderStatus.fromStatusString(status),
      addressLabel: addressLabel.isEmpty ? AppStrings.home : addressLabel,
      addressDetails: addressDetails,
      paymentLabel: _paymentLabel(paymentType),
      items: mappedItems,
      subTotal: computedSubTotal,
      deliveryFee: computedDeliveryFee,
      total: total,
      driverLat: driverLat,
      driverLng: driverLng,
    );
  }

  String _paymentLabel(String type) {
    final value = type.trim();
    if (value.isEmpty || value.toLowerCase().contains('cash')) {
      return AppStrings.payWithCash;
    }
    return value;
  }

  num _sumItems(List<TrackOrderItemEntity> items) =>
      items.fold<num>(0, (sum, item) => sum + (item.price * item.quantity));

  num _nonNegative(num value) => value > 0 ? value : 0;
}

extension TrackOrderItemModelMapper on TrackOrderItemModel {
  TrackOrderItemEntity toEntity() {
    return TrackOrderItemEntity(
      title: title,
      description: description,
      image: image,
      price: price,
      quantity: quantity,
    );
  }
}
