// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categories_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoriesResponseDto _$CategoriesResponseDtoFromJson(
  Map<String, dynamic> json,
) => CategoriesResponseDto(
  message: json['message'] as String?,
  metadata: json['metadata'] == null
      ? null
      : MetaDto.fromJson(json['metadata'] as Map<String, dynamic>),
  categories: (json['categories'] as List<dynamic>?)
      ?.map((e) => CategoryDto.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$CategoriesResponseDtoToJson(
  CategoriesResponseDto instance,
) => <String, dynamic>{
  'message': instance.message,
  'metadata': instance.metadata,
  'categories': instance.categories,
};
