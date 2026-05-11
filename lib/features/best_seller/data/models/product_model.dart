import 'package:flowers_app/core/entities/product_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel extends ProductEntity {
  @JsonKey(name: '_id')
  final String id;
  @JsonKey(name: 'title')
  final String name;
  @JsonKey(name: 'imgCover')
  final String image;
  @JsonKey(name: 'priceAfterDiscount')
  final double price;
  @JsonKey(name: 'price')
  final double? originalPrice;

  const ProductModel({
    required this.id,
    required this.name,
    required this.image,
    required this.price,
    this.originalPrice,
    super.discountPercentage,
    super.description,
    super.status,
    super.bouquetInclude,
  }) : super(
          id: id,
          name: name,
          image: image,
          price: price,
          originalPrice: originalPrice,
        );

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}
