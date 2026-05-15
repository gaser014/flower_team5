import 'package:flowers_app/config/base_response/entity/base_pagination_entity.dart';
import 'package:flowers_app/config/base_response/model/base_pagination_dto.dart';
import 'package:flowers_app/config/base_response/model/meta_dto.dart';
import 'package:flowers_app/features/home/presentation/categories/data/models/category_dto.dart';
import 'package:flowers_app/features/home/presentation/categories/domain/entities/category_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'categories_response_dto.g.dart';

@JsonSerializable()
class CategoriesResponseDto extends BasePaginationDto<CategoryDto> {
  @JsonKey(name: 'categories')
  final List<CategoryDto>? categories;
  const CategoriesResponseDto({super.message, super.metadata, this.categories})
    : super(data: categories);
  factory CategoriesResponseDto.fromJson(Map<String, dynamic> json) =>
      _$CategoriesResponseDtoFromJson(json);

  @override
  Map<String, dynamic> toJson(Object? Function(CategoryDto value) toJsonT) =>
      _$CategoriesResponseDtoToJson(this);

  @override
  BasePaginationEntity<CategoryEntity> toEntity() =>
      mapToEntity<CategoryEntity>((dto) => dto.toEntity());
}
