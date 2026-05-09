import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final String? id;
  final String? title;
  final String? description;
  final num? price;
  final num? priceAfterDiscount;
  final String? cover;

  const ProductEntity({
    this.id,
    this.title,
    this.description,
    this.price,
    this.priceAfterDiscount,
    this.cover,
  });

  @override
  List<Object?> get props => [id, title, description, price, priceAfterDiscount, cover];
}
