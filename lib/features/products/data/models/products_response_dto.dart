import 'package:flowers_app/config/base_response/entity/base_pagination_entity.dart';
import 'package:flowers_app/config/base_response/model/base_pagination_dto.dart';
import 'package:flowers_app/config/base_response/model/meta_dto.dart';
import 'package:flowers_app/features/products/data/models/product_dto.dart';
import 'package:flowers_app/features/products/domain/entities/product_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'products_response_dto.g.dart';

@JsonSerializable()
class ProductsResponseDto extends BasePaginationDto<ProductDto> {
  @JsonKey(name: 'products')
  final List<ProductDto>? products;

  const ProductsResponseDto({super.message, super.metadata, this.products})
    : super(data: products);

  factory ProductsResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ProductsResponseDtoFromJson(json);

  @override
  Map<String, dynamic> toJson(Object? Function(ProductDto value) toJsonT) =>
      _$ProductsResponseDtoToJson(this);

  @override
  BasePaginationEntity<ProductEntity> toEntity() =>
      mapToEntity<ProductEntity>((dto) => dto.toEntity());
}
