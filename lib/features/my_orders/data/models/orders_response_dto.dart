import 'package:flowers_app/features/my_orders/data/models/order_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'orders_response_dto.g.dart';

@JsonSerializable()
class OrdersResponseDto {
  @JsonKey(name: 'message')
  final String? message;

  @JsonKey(name: 'metadata')
  final Map<String, dynamic>? metadata;

  @JsonKey(name: 'orders')
  final List<OrderDto>? orders;

  const OrdersResponseDto({
    this.message,
    this.metadata,
    this.orders,
  });

  factory OrdersResponseDto.fromJson(Map<String, dynamic> json) =>
      _$OrdersResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$OrdersResponseDtoToJson(this);
}
