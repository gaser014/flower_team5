part of 'products_cubit.dart';

class ProductsStates extends Equatable {
  final PaginationState<ProductEntity> productsState;

  const ProductsStates({this.productsState = const PaginationState.initial()});

  ProductsStates copyWith({PaginationState<ProductEntity>? productsState}) {
    return ProductsStates(productsState: productsState ?? this.productsState);
  }

  @override
  List<Object?> get props => [productsState];
}
