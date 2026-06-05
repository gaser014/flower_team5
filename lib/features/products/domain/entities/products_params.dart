import 'package:flowers_app/config/uses_cases/filter_param.dart';
import 'package:flowers_app/config/uses_cases/pagination_params.dart';
import 'package:flowers_app/features/app_filter_tabs/domain/entities/app_filter_tabs_params.dart';
import 'package:flowers_app/features/app_filter_tabs/domain/entities/app_filter_tab_item_entity.dart';

enum SortType {
  newProduct("createdAt"),
  old("-createdAt"),
  lowestPrice("priceAfterDiscount"),
  highestPrice("-priceAfterDiscount"),
  discount("discount");

  final String value;
  const SortType(this.value);
}

class ProductsParams extends PaginationParams {
  final AppFilterTabItemEntity? category;
  final AppFilterTabsType type;
  final SortType? sortType;
  final String? search;

  const ProductsParams({
    this.category,
    this.type = AppFilterTabsType.categories,
    super.page,
    super.limit,
    super.filterList,
    this.sortType,
    this.search,
  });

  @override
  ProductsParams copyWith({
    AppFilterTabItemEntity? category,
    int? page,
    int? limit,
    AppFilterTabsType? type,
    List<FilterParam>? filterList,
    bool clearSearch = false,
    String? search,
    bool clearSort = false,
    SortType? sortType,
  }) {
    return ProductsParams(
      category: category ?? this.category,
      type: type ?? this.type,
      page: page ?? this.page,
      limit: limit ?? this.limit,
      filterList: filterList ?? this.filterList,
      search: clearSearch ? search : search ?? this.search,
      sortType: clearSort ? sortType : sortType ?? this.sortType,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final json = super.toJson();
    if (category?.id != null) json[type.parmKey] = category!.id;
    if (sortType != null) json["sort"] = sortType!.value;
    if (search != null) json["search"] = search;
    return json;
  }

  @override
  List<Object?> get props => [...super.props, category];
}
