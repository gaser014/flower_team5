import 'package:flowers_app/core/entities/product_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel {
  @JsonKey(name: '_id')
  final String? id;
  @JsonKey(name: 'title')
  final String? name;
  @JsonKey(name: 'imgCover')
  final String? image;
  @JsonKey(name: 'priceAfterDiscount')
  final double? price;
  @JsonKey(name: 'price')
  final double? originalPrice;
  final int? discountPercentage;
  final String? description;
  final String? status;
  final List<String>? bouquetInclude;

  const ProductModel({
    this.id,
    this.name,
    this.image,
    this.price,
    this.originalPrice,
    this.discountPercentage,
    this.description,
    this.status,
    this.bouquetInclude,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);

  ProductEntity toEntity() => ProductEntity(
        id: id ?? '',
        name: name ?? '',
        image: image ?? '',
        price: price ?? 0,
        originalPrice: originalPrice,
        discountPercentage: discountPercentage,
        description: description,
        status: status,
        bouquetInclude: bouquetInclude,
      );
}
