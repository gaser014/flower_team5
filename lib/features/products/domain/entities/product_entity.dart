import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final String? id;
  final String? title;
  final String? slug;
  final String? description;
  final String? imgCover;
  final List<String>? images;
  final int? price;
  final int? priceAfterDiscount;
  final int? discount;
  final int? rateAvg;
  final int? rateCount;
  final int? sold;
  final int? quantity;
  final String? category;
  final String? occasion;
  final bool? isSuperAdmin;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? favoriteId;
  final bool? isInWishlist;

  const ProductEntity({
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

  ProductEntity copyWith({
    String? id,
    String? title,
    String? slug,
    String? description,
    String? imgCover,
    List<String>? images,
    int? price,
    int? priceAfterDiscount,
    int? discount,
    int? rateAvg,
    int? rateCount,
    int? sold,
    int? quantity,
    String? category,
    String? occasion,
    bool? isSuperAdmin,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? favoriteId,
    bool? isInWishlist,
  }) {
    return ProductEntity(
      id: id ?? this.id,
      title: title ?? this.title,
      slug: slug ?? this.slug,
      description: description ?? this.description,
      imgCover: imgCover ?? this.imgCover,
      images: images ?? this.images,
      price: price ?? this.price,
      priceAfterDiscount: priceAfterDiscount ?? this.priceAfterDiscount,
      discount: discount ?? this.discount,
      rateAvg: rateAvg ?? this.rateAvg,
      rateCount: rateCount ?? this.rateCount,
      sold: sold ?? this.sold,
      quantity: quantity ?? this.quantity,
      category: category ?? this.category,
      occasion: occasion ?? this.occasion,
      isSuperAdmin: isSuperAdmin ?? this.isSuperAdmin,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      favoriteId: favoriteId ?? this.favoriteId,
      isInWishlist: isInWishlist ?? this.isInWishlist,
    );
  }

  @override
  List<Object?> get props => [
    id,
    title,
    slug,
    description,
    imgCover,
    images,
    price,
    priceAfterDiscount,
    discount,
    rateAvg,
    rateCount,
    sold,
    quantity,
    category,
    occasion,
    isSuperAdmin,
    createdAt,
    updatedAt,
    favoriteId,
    isInWishlist,
  ];
}
