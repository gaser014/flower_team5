import 'package:flowers_app/features/products/data/models/product_dto.dart';
import 'package:flowers_app/features/products/domain/entities/product_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_details_response_dto.g.dart';

@JsonSerializable()
class ProductDetailsResponseDto {
  final String? message;
  @JsonKey(name: 'product')
  final ProductDto? product;

  const ProductDetailsResponseDto({this.message, this.product});

  factory ProductDetailsResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ProductDetailsResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDetailsResponseDtoToJson(this);

  ProductEntity toEntity() => product!.toEntity();
}
