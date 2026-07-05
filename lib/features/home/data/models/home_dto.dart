import 'package:flowers_app/features/home/data/models/home_category_dto.dart';
import 'package:flowers_app/features/home/data/models/home_occasion_dto.dart';
import 'package:flowers_app/features/home/domain/entities/home_entity.dart';
import 'package:flowers_app/features/products/data/models/product_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'home_dto.g.dart';

@JsonSerializable()
class HomeDto {
  @JsonKey(name: 'products')
  final List<ProductDto>? products;

  @JsonKey(name: 'categories')
  final List<HomeCategoryDto>? categories;

  @JsonKey(name: 'bestSeller')
  final List<ProductDto>? bestSeller;

  @JsonKey(name: 'occasions')
  final List<HomeOccasionDto>? occasions;

  const HomeDto({
    this.products,
    this.categories,
    this.bestSeller,
    this.occasions,
  });

  factory HomeDto.fromJson(Map<String, dynamic> json) =>
      _$HomeDtoFromJson(json);

  Map<String, dynamic> toJson() => _$HomeDtoToJson(this);

  factory HomeDto.fromEntity(HomeEntity entity) {
    return HomeDto(
      products: entity.products?.map((e) => ProductDto.fromEntity(e)).toList(),
      categories:
          entity.categories?.map((e) => HomeCategoryDto.fromEntity(e)).toList(),
      bestSeller:
          entity.bestSeller?.map((e) => ProductDto.fromEntity(e)).toList(),
      occasions:
          entity.occasions?.map((e) => HomeOccasionDto.fromEntity(e)).toList(),
    );
  }

  HomeEntity toEntity() {
    return HomeEntity(
      products: products?.map((e) => e.toEntity()).toList(),
      categories: categories?.map((e) => e.toEntity()).toList(),
      bestSeller: bestSeller?.map((e) => e.toEntity()).toList(),
      occasions: occasions?.map((e) => e.toEntity()).toList(),
    );
  }
}
