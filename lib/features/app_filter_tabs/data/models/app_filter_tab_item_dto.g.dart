// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_filter_tab_item_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppFilterTabItemDto _$AppFilterTabItemDtoFromJson(Map<String, dynamic> json) =>
    AppFilterTabItemDto(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      slug: json['slug'] as String?,
      image: json['image'] as String?,
      isSuperAdmin: json['isSuperAdmin'] as bool?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      productsCount: (json['productsCount'] as num?)?.toInt(),
    );

Map<String, dynamic> _$AppFilterTabItemDtoToJson(
  AppFilterTabItemDto instance,
) => <String, dynamic>{
  '_id': instance.id,
  'name': instance.name,
  'slug': instance.slug,
  'image': instance.image,
  'isSuperAdmin': instance.isSuperAdmin,
  'createdAt': instance.createdAt?.toIso8601String(),
  'updatedAt': instance.updatedAt?.toIso8601String(),
  'productsCount': instance.productsCount,
};
