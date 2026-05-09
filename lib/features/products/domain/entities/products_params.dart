import 'package:flowers_app/config/uses_cases/pagination_params.dart';
import 'package:flowers_app/features/categories/domain/entities/categories_params.dart';
import 'package:flowers_app/features/categories/domain/entities/category_entity.dart';

class ProductsParams extends PaginationParams {
  final CategoryEntity? category;
  final CategoriesType type;

  final String? keyword;
  final String? sort;
  final bool clearCategory;

  const ProductsParams({
    this.category,
    this.type = CategoriesType.categories,
    this.keyword,
    this.sort,
    this.clearCategory = false,
    super.page,
    super.limit,
    super.filterList,
  });

  @override
  ProductsParams copyWith({
    CategoryEntity? category,
    int? page,
    int? limit,
    String? keyword,
    String? sort,
    bool? clearCategory,
    CategoriesType? type,
  }) {
    return ProductsParams(
      category: category ?? this.category,
      type: type ?? this.type,
      keyword: keyword ?? this.keyword,
      sort: sort ?? this.sort,
      clearCategory: clearCategory ?? this.clearCategory,
      page: page ?? this.page,
      limit: limit ?? this.limit,
      filterList: filterList,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    if (!clearCategory && category != null) json[type.parmKey] = category!.id;
    if (keyword != null && keyword!.isNotEmpty) json['keyword'] = keyword;
    if (sort != null && sort!.isNotEmpty) json['sort'] = sort;
    return json;
  }

  @override
  List<Object?> get props => [...super.props, category];
}
