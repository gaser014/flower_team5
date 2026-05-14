import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final String id;
  final String name;
  final String image;
  final double price;
  final double? originalPrice;
  final int? discountPercentage;
  final String? description;
  final String? status;
  final List<String>? bouquetInclude;

  const ProductEntity({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    this.originalPrice,
    this.discountPercentage,
    this.description,
    this.status,
    this.bouquetInclude,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        image,
        price,
        originalPrice,
        discountPercentage,
        description,
        status,
        bouquetInclude,
      ];
}
