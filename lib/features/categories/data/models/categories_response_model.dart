import 'package:json_annotation/json_annotation.dart';
import 'category_model.dart';
import 'metadata_model.dart';

part 'categories_response_model.g.dart';

@JsonSerializable()
class CategoriesResponseModel {
  final String? message;
  final MetadataModel? metadata;
  final List<CategoryModel>? categories;

  CategoriesResponseModel({
    this.message,
    this.metadata,
    this.categories,
  });

  factory CategoriesResponseModel.fromJson(Map<String, dynamic> json) => _$CategoriesResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$CategoriesResponseModelToJson(this);
}
