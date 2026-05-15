// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_details_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductDetailsResponseDto _$ProductDetailsResponseDtoFromJson(
  Map<String, dynamic> json,
) => ProductDetailsResponseDto(
  message: json['message'] as String?,
  product: json['product'] == null
      ? null
      : ProductDto.fromJson(json['product'] as Map<String, dynamic>),
);

Map<String, dynamic> _$ProductDetailsResponseDtoToJson(
  ProductDetailsResponseDto instance,
) => <String, dynamic>{
  'message': instance.message,
  'product': instance.product,
};
