import 'package:flowers_app/config/uses_cases/pagination_params.dart';
import 'package:flowers_app/features/categories/domain/entities/categories_params.dart';
import 'package:flowers_app/features/categories/domain/entities/category_entity.dart';

class ProductsParams extends PaginationParams {
  final CategoryEntity? category;
  final CategoriesType type;

  const ProductsParams({
    this.category,
    this.type = CategoriesType.categories,
    super.page,
    super.limit,
    super.filterList,
  });

  @override
  ProductsParams copyWith({
    CategoryEntity? category,
    int? page,
    int? limit,
    CategoriesType? type,
  }) {
    return ProductsParams(
      category: category ?? this.category,
      type: type ?? this.type,
      page: page ?? this.page,
      limit: limit ?? this.limit,
      filterList: filterList,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    if (category != null) json[type.parmKey] = category!.id;
    return json;
  }

  @override
  List<Object?> get props => [...super.props, category];
}
