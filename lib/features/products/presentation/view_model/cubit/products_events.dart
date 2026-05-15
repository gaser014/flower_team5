part of 'products_cubit.dart';

sealed class ProductsEvents {
  const ProductsEvents();
}

class GetAllProductsEvent extends ProductsEvents {
  final ProductsParams? params;
  const GetAllProductsEvent({this.params});
}

class UpdateSortByEvent extends ProductsEvents {
  final SortType sortBy;
  const UpdateSortByEvent({required this.sortBy});
}

class LoadMoreProductsEvent extends ProductsEvents {
  final ProductsParams params;
  const LoadMoreProductsEvent({required this.params});
}

class SearchProductsEvent extends ProductsEvents {
  final String query;
  const SearchProductsEvent({required this.query});
}
