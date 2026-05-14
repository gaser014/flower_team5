import 'package:flowers_app/config/uses_cases/pagination_params.dart';

class AppFilterTabsParams extends PaginationParams {
  final AppFilterTabsType type;

  const AppFilterTabsParams({
    this.type = AppFilterTabsType.categories,
    super.page,
    super.limit = 500,
    super.filterList,
  });

  @override
  AppFilterTabsParams copyWith({
    AppFilterTabsType? type,
    int? page,
    int? limit,
  }) {
    return AppFilterTabsParams(
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

enum AppFilterTabsType {
  categories("categories", "category"),
  occasions("occasions", "occasion");

  final String value;
  final String parmKey;

  const AppFilterTabsType(this.value, this.parmKey);
}
