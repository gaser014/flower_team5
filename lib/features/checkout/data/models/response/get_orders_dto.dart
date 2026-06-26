class GetOrdersDto {
  final List<Map<String, dynamic>> orders;

  GetOrdersDto({required this.orders});

  factory GetOrdersDto.fromJson(Map<String, dynamic> json) {
    final raw = json['orders'] ?? json['data'] ?? json['order'];
    final list = raw is List
        ? raw
              .whereType<Map>()
              .map((e) => e.cast<String, dynamic>())
              .toList(growable: false)
        : <Map<String, dynamic>>[];
    return GetOrdersDto(orders: list);
  }

  Map<String, dynamic>? get latest {
    if (orders.isEmpty) return null;
    Map<String, dynamic>? best;
    DateTime? bestDate;
    for (final order in orders) {
      final date = DateTime.tryParse((order['createdAt'] ?? '').toString());
      final isNewer = bestDate == null || (date != null && date.isAfter(bestDate));
      if (best == null || isNewer) {
        best = order;
        bestDate = date ?? bestDate;
      }
    }
    return best ?? orders.last;
  }
}
