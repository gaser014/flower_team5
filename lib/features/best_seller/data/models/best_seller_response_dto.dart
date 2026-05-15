import 'package:flowers_app/config/base_response/entity/base_pagination_entity.dart';
import 'package:flowers_app/config/base_response/entity/meta_entity.dart';
import 'package:flowers_app/features/products/data/models/product_dto.dart';
import 'package:flowers_app/features/products/data/models/product_dto.dart';
import 'package:flowers_app/features/products/domain/entities/product_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'best_seller_response_dto.g.dart';

@JsonSerializable()
class BestSellerResponseDto {
  final String? message;
  @JsonKey(name: 'bestSeller')
  final List<ProductDto>? bestSellers;

  const BestSellerResponseDto({this.message, this.bestSellers});

  factory BestSellerResponseDto.fromJson(Map<String, dynamic> json) =>
      _$BestSellerResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$BestSellerResponseDtoToJson(this);

  BasePaginationEntity<ProductEntity> toEntity() {
    return BasePaginationEntity<ProductEntity>(
      meta: const MetaEntity.empty(),
      data:
          bestSellers?.map((productDto) => productDto.toEntity()).toList() ??
          [],
    );
  }
}
