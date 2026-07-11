part of 'products_cubit.dart';

sealed class ProductsEvents {
  const ProductsEvents();
}

class GetAllProductsEvent extends ProductsEvents {
  final ProductsParams? params;
  const GetAllProductsEvent({this.params});
}

class LoadMoreProductsEvent extends ProductsEvents {
  final ProductsParams params;
  const LoadMoreProductsEvent({required this.params});
}
class SearchProductsEvent extends ProductsEvents {
  final String query;
  const SearchProductsEvent({required this.query});
}

class UpdateSortByEvent extends ProductsEvents {
  final String sortBy;
  const UpdateSortByEvent({required this.sortBy});
}
