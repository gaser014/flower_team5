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
  final ProductsParams params;
  const SearchProductsEvent({required this.params});
}

class ClearCategoryEvent extends ProductsEvents {
  const ClearCategoryEvent();
}
