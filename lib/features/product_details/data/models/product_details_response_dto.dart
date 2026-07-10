import 'package:flowers_app/features/best_seller/data/models/product_model.dart';
import 'package:flowers_app/core/entities/product_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_details_response_dto.g.dart';

@JsonSerializable()
class ProductDetailsResponseDto {
  final String? message;
  @JsonKey(name: 'product')
  final ProductModel? product;

  const ProductDetailsResponseDto({
    this.message,
    this.product,
  });

  factory ProductDetailsResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ProductDetailsResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDetailsResponseDtoToJson(this);

  ProductEntity toEntity() => product!.toEntity();
}
