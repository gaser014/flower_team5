import 'package:flowers_app/config/base_response/entity/base_pagination_entity.dart';
import 'package:flowers_app/config/base_response/model/base_pagination_dto.dart';
import 'package:flowers_app/config/base_response/model/meta_dto.dart';
import 'package:flowers_app/features/app_filter_tabs/data/models/app_filter_tab_item_dto.dart';
import 'package:flowers_app/features/app_filter_tabs/domain/entities/app_filter_tab_item_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'occasions_response_dto.g.dart';

@JsonSerializable()
class OccasionsResponseDto extends BasePaginationDto<AppFilterTabItemDto> {
  @JsonKey(name: 'occasions')
  final List<AppFilterTabItemDto>? occasions;
  const OccasionsResponseDto({super.message, super.metadata, this.occasions})
    : super(data: occasions);
  factory OccasionsResponseDto.fromJson(Map<String, dynamic> json) =>
      _$OccasionsResponseDtoFromJson(json);

  @override
  Map<String, dynamic> toJson(
    Object? Function(AppFilterTabItemDto value) toJsonT,
  ) => _$OccasionsResponseDtoToJson(this);

  @override
  BasePaginationEntity<AppFilterTabItemEntity> toEntity() =>
      mapToEntity<AppFilterTabItemEntity>((dto) => dto.toEntity());
}
