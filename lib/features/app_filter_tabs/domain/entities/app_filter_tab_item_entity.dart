import 'package:equatable/equatable.dart';

class AppFilterTabItemEntity extends Equatable {
  final String? id;
  final String? name;
  final String? slug;
  final String? image;
  final bool? isSuperAdmin;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? productsCount;

  const AppFilterTabItemEntity({
    this.id,
    this.name,
    this.slug,
    this.image,
    this.isSuperAdmin,
    this.createdAt,
    this.updatedAt,
    this.productsCount,
  });

  AppFilterTabItemEntity copyWith({
    String? id,
    String? name,
    String? slug,
    String? image,
    bool? isSuperAdmin,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? productsCount,
  }) {
    return AppFilterTabItemEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      slug: slug ?? this.slug,
      image: image ?? this.image,
      isSuperAdmin: isSuperAdmin ?? this.isSuperAdmin,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      productsCount: productsCount ?? this.productsCount,
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    slug,
    image,
    isSuperAdmin,
    createdAt,
    updatedAt,
    productsCount,
  ];
}
