import 'package:flowers_app/features/app_filter_tabs/domain/entities/app_filter_tab_item_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'home_occasion_dto.g.dart';

@JsonSerializable()
class HomeOccasionDto {
  @JsonKey(name: '_id')
  final String? id;

  @JsonKey(name: 'name')
  final String? name;

  @JsonKey(name: 'slug')
  final String? slug;

  @JsonKey(name: 'image')
  final String? image;

  @JsonKey(name: 'isSuperAdmin')
  final bool? isSuperAdmin;

  @JsonKey(name: 'createdAt')
  final DateTime? createdAt;

  @JsonKey(name: 'updatedAt')
  final DateTime? updatedAt;

  const HomeOccasionDto({
    this.id,
    this.name,
    this.slug,
    this.image,
    this.isSuperAdmin,
    this.createdAt,
    this.updatedAt,
  });

  factory HomeOccasionDto.fromJson(Map<String, dynamic> json) =>
      _$HomeOccasionDtoFromJson(json);

  Map<String, dynamic> toJson() => _$HomeOccasionDtoToJson(this);

  factory HomeOccasionDto.fromEntity(AppFilterTabItemEntity entity) {
    return HomeOccasionDto(
      id: entity.id,
      name: entity.name,
      slug: entity.slug,
      image: entity.image,
      isSuperAdmin: entity.isSuperAdmin,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
    );
  }

  AppFilterTabItemEntity toEntity() {
    return AppFilterTabItemEntity(
      id: id,
      name: name,
      slug: slug,
      image: image,
      isSuperAdmin: isSuperAdmin,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );
  }
}
