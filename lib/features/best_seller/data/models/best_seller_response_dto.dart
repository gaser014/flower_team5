import 'package:flowers_app/config/base_response/entity/base_pagination_entity.dart';
import 'package:flowers_app/config/base_response/entity/meta_entity.dart';
import 'package:flowers_app/core/entities/product_entity.dart';
import 'package:flowers_app/features/best_seller/data/models/product_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'best_seller_response_dto.g.dart';

@JsonSerializable()
class BestSellerResponseDto {
  final String? message;
  @JsonKey(name: 'bestSeller')
  final List<ProductModel>? bestSellers;

  const BestSellerResponseDto({this.message, this.bestSellers});

  factory BestSellerResponseDto.fromJson(Map<String, dynamic> json) =>
      _$BestSellerResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$BestSellerResponseDtoToJson(this);

  BasePaginationEntity<ProductEntity> toEntity() {
    return BasePaginationEntity<ProductEntity>(
      meta: const MetaEntity.empty(),
      data: bestSellers?.map((model) => model.toEntity()).toList() ?? [],
    );
  }
}
