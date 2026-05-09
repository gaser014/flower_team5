import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/product_entity.dart';

part 'product_model.g.dart';

@JsonSerializable()
class ProductModel {
  @JsonKey(name: '_id')
  final String? id;
  final String? title;
  final String? description;
  final num? price;
  final num? priceAfterDiscount;
  final String? cover;

  ProductModel({
    this.id,
    this.title,
    this.description,
    this.price,
    this.priceAfterDiscount,
    this.cover,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => _$ProductModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProductModelToJson(this);

  ProductEntity toEntity() => ProductEntity(
    id: id,
    title: title,
    description: description,
    price: price,
    priceAfterDiscount: priceAfterDiscount,
    cover: cover,
  );
}
