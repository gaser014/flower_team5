import 'package:flowers_app/features/products/domain/entities/product_entity.dart';

sealed class ProductDetailsEvents {}

/// Fetch product from the API using its ID.
/// Use this when you only have the product ID (e.g. deep links, notifications).
class GetProductDetailsEvent extends ProductDetailsEvents {
  final String id;
  GetProductDetailsEvent({required this.id});
}

/// Set product directly without an API call.
/// Use this when navigating from a list where the full entity is already available.
class SetProductDetailsEvent extends ProductDetailsEvents {
  final ProductEntity product;
  SetProductDetailsEvent({required this.product});
}
