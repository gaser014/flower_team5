class CashOnDeliveryDto {
  final String? error;
  final String? message;
  final String? orderNumber;
  final String? paymentType;

  CashOnDeliveryDto({
    this.error,
    this.message,
    this.orderNumber,
    this.paymentType,
  });

  factory CashOnDeliveryDto.fromJson(Map<String, dynamic> json) =>
      CashOnDeliveryDto(
        error: json['error'],
        message: json['message'],
        orderNumber: json['order']?['orderNumber'],
        paymentType: json['order']?['paymentType'],
      );

  Map<String, dynamic> toJson() => {
        'error': error,
        'message': message,
        if (orderNumber != null || paymentType != null)
          'order': {
            if (orderNumber != null) 'orderNumber': orderNumber,
            if (paymentType != null) 'paymentType': paymentType,
          },
      };
}
