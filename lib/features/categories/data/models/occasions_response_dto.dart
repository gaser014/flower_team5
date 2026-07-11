import 'package:flowers_app/config/base_response/entity/base_pagination_entity.dart';
import 'package:flowers_app/config/base_response/model/base_pagination_dto.dart';
import 'package:flowers_app/config/base_response/model/meta_dto.dart';
import 'category_dto.dart';
import '../../domain/entities/category_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'occasions_response_dto.g.dart';

@JsonSerializable()
class OccasionsResponseDto extends BasePaginationDto<CategoryDto> {
  @JsonKey(name: 'occasions')
  final List<CategoryDto>? occasions;
  const OccasionsResponseDto({super.message, super.metadata, this.occasions})
    : super(data: occasions);
  factory OccasionsResponseDto.fromJson(Map<String, dynamic> json) =>
      _$OccasionsResponseDtoFromJson(json);

  @override
  Map<String, dynamic> toJson(Object? Function(CategoryDto value) toJsonT) =>
      _$OccasionsResponseDtoToJson(this);

  @override
  BasePaginationEntity<CategoryEntity> toEntity() =>
      mapToEntity<CategoryEntity>((dto) => dto.toEntity());
}
