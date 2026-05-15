import 'package:flowers_app/config/uses_cases/filter_param.dart';
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
  CategoriesParams copyWith({
    CategoriesType? type,
    int? page,
    int? limit,
    List<FilterParam>? filterList,
  }) {
    return CategoriesParams(
      type: type ?? this.type,
      page: page ?? this.page,
      limit: limit ?? this.limit,
      filterList: filterList ?? this.filterList,
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

enum CategoriesType {
  categories("categories", "category"),
  occasions("occasions", "occasion");

  final String value;
  final String parmKey;

  const CategoriesType(this.value, this.parmKey);
}
