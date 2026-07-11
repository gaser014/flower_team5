class CashOnDeliveryDto {
  final String? error;
  final String? message;
  final String? orderId;
  final String? orderNumber;
  final String? paymentType;
  final Map<String, dynamic>? order;

  CashOnDeliveryDto({
    this.error,
    this.message,
    this.orderId,
    this.orderNumber,
    this.paymentType,
    this.order,
  });

  factory CashOnDeliveryDto.fromJson(Map<String, dynamic> json) {
    final order = json['order'] is Map
        ? (json['order'] as Map).cast<String, dynamic>()
        : null;
    return CashOnDeliveryDto(
      error: json['error'],
      message: json['message'],
      orderId: (order?['_id'] ?? order?['id'])?.toString(),
      orderNumber: order?['orderNumber']?.toString(),
      paymentType: order?['paymentType']?.toString(),
      order: order,
    );
  }

  Map<String, dynamic> toJson() => {
    'error': error,
    'message': message,
    if (order != null) 'order': order,
  };
}
