import 'package:equatable/equatable.dart';
import 'package:flowers_app/features/products/domain/entities/product_entity.dart';

class OrderItemEntity extends Equatable {
  final String? id;
  final ProductEntity? product;
  final num? price;
  final num? quantity;

  const OrderItemEntity({
    this.id,
    this.product,
    this.price,
    this.quantity,
  });

  @override
  List<Object?> get props => [id, product, price, quantity];
}
