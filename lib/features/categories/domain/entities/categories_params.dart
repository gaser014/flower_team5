import 'package:flowers_app/config/uses_cases/pagination_params.dart';

class CategoriesParams extends PaginationParams {
  final CategoriesType type;

  const CategoriesParams({
    this.type = CategoriesType.categories,
    super.page,
    super.limit = 500,
    super.filterList,
  });

  @override
  CategoriesParams copyWith({CategoriesType? type, int? page, int? limit}) {
    return CategoriesParams(
      type: type ?? this.type,
      page: page ?? this.page,
      limit: limit ?? this.limit,
      filterList: filterList,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    return json;
  }

  @override
  List<Object?> get props => [...super.props, type];
}

enum CategoriesType { categories, occasions }
