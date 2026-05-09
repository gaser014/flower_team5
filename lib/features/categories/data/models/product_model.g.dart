// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
  id: json['_id'] as String?,
  title: json['title'] as String?,
  description: json['description'] as String?,
  price: json['price'] as num?,
  priceAfterDiscount: json['priceAfterDiscount'] as num?,
  cover: json['cover'] as String?,
);

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'price': instance.price,
      'priceAfterDiscount': instance.priceAfterDiscount,
      'cover': instance.cover,
    };
