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
