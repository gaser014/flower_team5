import 'package:flowers_app/features/products/domain/entities/product_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_dto.g.dart';

@JsonSerializable()
class ProductDto {
  @JsonKey(name: '_id')
  final String? id;

  @JsonKey(name: 'title')
  final String? title;

  @JsonKey(name: 'slug')
  final String? slug;

  @JsonKey(name: 'description')
  final String? description;

  @JsonKey(name: 'imgCover')
  final String? imgCover;

  @JsonKey(name: 'images')
  final List<String>? images;

  @JsonKey(name: 'price')
  final num? price;

  @JsonKey(name: 'priceAfterDiscount')
  final num? priceAfterDiscount;

  @JsonKey(name: 'discount')
  final num? discount;

  @JsonKey(name: 'rateAvg')
  final num? rateAvg;

  @JsonKey(name: 'rateCount')
  final num? rateCount;

  @JsonKey(name: 'sold')
  final num? sold;

  @JsonKey(name: 'quantity')
  final num? quantity;

  @JsonKey(name: 'category')
  final String? category;

  @JsonKey(name: 'occasion')
  final String? occasion;

  @JsonKey(name: 'isSuperAdmin')
  final bool? isSuperAdmin;

  @JsonKey(name: 'createdAt')
  final DateTime? createdAt;

  @JsonKey(name: 'updatedAt')
  final DateTime? updatedAt;

  @JsonKey(name: 'favoriteId')
  final String? favoriteId;

  @JsonKey(name: 'isInWishlist')
  final bool? isInWishlist;

  const ProductDto({
    this.id,
    this.title,
    this.slug,
    this.description,
    this.imgCover,
    this.images,
    this.price,
    this.priceAfterDiscount,
    this.discount,
    this.rateAvg,
    this.rateCount,
    this.sold,
    this.quantity,
    this.category,
    this.occasion,
    this.isSuperAdmin,
    this.createdAt,
    this.updatedAt,
    this.favoriteId,
    this.isInWishlist,
  });

  factory ProductDto.fromJson(Map<String, dynamic> json) =>
      _$ProductDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ProductDtoToJson(this);

  factory ProductDto.fromEntity(ProductEntity entity) {
    return ProductDto(
      id: entity.id,
      title: entity.title,
      slug: entity.slug,
      description: entity.description,
      imgCover: entity.imgCover,
      images: entity.images,
      price: entity.price,
      priceAfterDiscount: entity.priceAfterDiscount,
      discount: entity.discount,
      rateAvg: entity.rateAvg,
      rateCount: entity.rateCount,
      sold: entity.sold,
      quantity: entity.quantity,
      category: entity.category,
      occasion: entity.occasion,
      isSuperAdmin: entity.isSuperAdmin,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      favoriteId: entity.favoriteId,
      isInWishlist: entity.isInWishlist,
    );
  }

  ProductEntity toEntity() {
    return ProductEntity(
      id: id,
      title: title,
      slug: slug,
      description: description,
      imgCover: imgCover,
      images: images,
      price: price,
      priceAfterDiscount: priceAfterDiscount,
      discount: discount,
      rateAvg: rateAvg,
      rateCount: rateCount,
      sold: sold,
      quantity: quantity,
      category: category,
      occasion: occasion,
      isSuperAdmin: isSuperAdmin,
      createdAt: createdAt,
      updatedAt: updatedAt,
      favoriteId: favoriteId,
      isInWishlist: isInWishlist,
    );
  }
}
