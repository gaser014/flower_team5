class TrackOrderModel {
  final String id;
  final String orderNumber;
  final String status;
  final String addressLabel;
  final String addressDetails;
  final String paymentType;
  final List<TrackOrderItemModel> items;
  final num? subTotal;
  final num? deliveryFee;
  final num total;
  final double? driverLat;
  final double? driverLng;

  const TrackOrderModel({
    required this.id,
    required this.orderNumber,
    required this.status,
    required this.addressLabel,
    required this.addressDetails,
    required this.paymentType,
    required this.items,
    required this.total,
    this.subTotal,
    this.deliveryFee,
    this.driverLat,
    this.driverLng,
  });

  factory TrackOrderModel.fromMap(String id, Map<String, dynamic> map) {
    final customer = _asMap(map['customer']);
    final location = _asMap(map['driverLocation']);
    final rawItems = map['items'];

    return TrackOrderModel(
      id: (map['orderId'] ?? id).toString(),
      orderNumber: (map['orderNumber'] ?? '').toString(),
      status: (map['status'] ?? '').toString(),
      addressLabel: (map['addressLabel'] ?? customer['label'] ?? '').toString(),
      addressDetails: (map['address'] ?? customer['address'] ?? '').toString(),
      paymentType: (map['paymentType'] ?? map['paymentMethod'] ?? '')
          .toString(),
      items: rawItems is List
          ? rawItems
                .whereType<Map>()
                .map((e) => TrackOrderItemModel.fromMap(e.cast()))
                .toList(growable: false)
          : const [],
      subTotal: _toNum(map['subTotal']),
      deliveryFee: _toNum(map['deliveryFee']),
      total: _toNum(map['totalPrice']) ?? _toNum(map['total']) ?? 0,
      driverLat: _toDouble(location['lat']),
      driverLng: _toDouble(location['lng']),
    );
  }
}

class TrackOrderItemModel {
  final String title;
  final String description;
  final String image;
  final num price;
  final int quantity;

  const TrackOrderItemModel({
    required this.title,
    required this.description,
    required this.image,
    required this.price,
    required this.quantity,
  });

  factory TrackOrderItemModel.fromMap(Map<String, dynamic> map) {
    return TrackOrderItemModel(
      title: (map['title'] ?? map['name'] ?? '').toString(),
      description: (map['description'] ?? map['desc'] ?? '').toString(),
      image: (map['image'] ?? map['imgCover'] ?? map['imageUrl'] ?? '')
          .toString(),
      price: _toNum(map['price']) ?? 0,
      quantity: (_toNum(map['quantity']) ?? 1).toInt(),
    );
  }
}

Map<String, dynamic> _asMap(Object? value) =>
    value is Map ? value.cast<String, dynamic>() : const {};

num? _toNum(Object? value) {
  if (value is num) return value;
  if (value is String) return num.tryParse(value);
  return null;
}

double? _toDouble(Object? value) {
  if (value is num) return value.toDouble();
  if (value is String) return double.tryParse(value);
  return null;
}
