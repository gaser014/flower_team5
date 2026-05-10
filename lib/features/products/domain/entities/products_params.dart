import 'package:flowers_app/config/uses_cases/pagination_params.dart';
import 'package:flowers_app/features/app_filter_tabs/domain/entities/app_filter_tabs_params.dart';
import 'package:flowers_app/features/app_filter_tabs/domain/entities/app_filter_tab_item_entity.dart';

class ProductsParams extends PaginationParams {
  final AppFilterTabItemEntity? category;
  final AppFilterTabsType type;

  const ProductsParams({
    this.category,
    this.type = AppFilterTabsType.categories,
    super.page,
    super.limit,
    super.filterList,
  });

  @override
  ProductsParams copyWith({
    AppFilterTabItemEntity? category,
    int? page,
    int? limit,
    AppFilterTabsType? type,
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
