import 'package:flowers_app/features/my_orders/domain/entities/order_item_entity.dart';
import 'package:flowers_app/features/products/data/models/product_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_item_dto.g.dart';

@JsonSerializable()
class OrderItemDto {
  @JsonKey(name: '_id')
  final String? id;

  @JsonKey(name: 'product')
  final ProductDto? product;

  @JsonKey(name: 'price')
  final num? price;

  @JsonKey(name: 'quantity')
  final num? quantity;

  const OrderItemDto({
    this.id,
    this.product,
    this.price,
    this.quantity,
  });

  factory OrderItemDto.fromJson(Map<String, dynamic> json) =>
      _$OrderItemDtoFromJson(json);

  Map<String, dynamic> toJson() => _$OrderItemDtoToJson(this);

  OrderItemEntity toEntity() {
    return OrderItemEntity(
      id: id,
      product: product?.toEntity(),
      price: price,
      quantity: quantity,
    );
  }
}
