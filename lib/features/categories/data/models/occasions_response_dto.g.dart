// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'occasions_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OccasionsResponseDto _$OccasionsResponseDtoFromJson(
  Map<String, dynamic> json,
) => OccasionsResponseDto(
  message: json['message'] as String?,
  metadata: json['metadata'] == null
      ? null
      : MetaDto.fromJson(json['metadata'] as Map<String, dynamic>),
  occasions: (json['occasions'] as List<dynamic>?)
      ?.map((e) => CategoryDto.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$OccasionsResponseDtoToJson(
  OccasionsResponseDto instance,
) => <String, dynamic>{
  'message': instance.message,
  'metadata': instance.metadata,
  'occasions': instance.occasions,
};
