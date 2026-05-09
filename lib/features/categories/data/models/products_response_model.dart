import 'package:json_annotation/json_annotation.dart';
import 'product_model.dart';

part 'products_response_model.g.dart';

@JsonSerializable()
class ProductsResponseModel {
  final String? message;
  final List<ProductModel>? products;

  ProductsResponseModel({this.message, this.products});

  factory ProductsResponseModel.fromJson(Map<String, dynamic> json) => _$ProductsResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProductsResponseModelToJson(this);
}
