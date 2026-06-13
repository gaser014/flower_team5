import 'package:flowers_app/features/my_orders/domain/entities/order_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_dto.g.dart';

@JsonSerializable()
class OrderDto {
  @JsonKey(name: '_id')
  final String? id;

  @JsonKey(name: 'user')
  final String? user;

  @JsonKey(name: 'orderItems')
  final List<dynamic>? orderItems;

  @JsonKey(name: 'totalPrice')
  final num? totalPrice;

  @JsonKey(name: 'paymentType')
  final String? paymentType;

  @JsonKey(name: 'isPaid')
  final bool? isPaid;

  @JsonKey(name: 'isDelivered')
  final bool? isDelivered;

  @JsonKey(name: 'state')
  final String? state;

  @JsonKey(name: 'createdAt')
  final DateTime? createdAt;

  @JsonKey(name: 'updatedAt')
  final DateTime? updatedAt;

  @JsonKey(name: 'orderNumber')
  final String? orderNumber;

  const OrderDto({
    this.id,
    this.user,
    this.orderItems,
    this.totalPrice,
    this.paymentType,
    this.isPaid,
    this.isDelivered,
    this.state,
    this.createdAt,
    this.updatedAt,
    this.orderNumber,
  });

  factory OrderDto.fromJson(Map<String, dynamic> json) =>
      _$OrderDtoFromJson(json);

  Map<String, dynamic> toJson() => _$OrderDtoToJson(this);

  OrderEntity toEntity() {
    return OrderEntity(
      id: id,
      user: user,
      orderItems: orderItems,
      totalPrice: totalPrice,
      paymentType: paymentType,
      isPaid: isPaid,
      isDelivered: isDelivered,
      state: state,
      createdAt: createdAt,
      updatedAt: updatedAt,
      orderNumber: orderNumber,
    );
  }
}
