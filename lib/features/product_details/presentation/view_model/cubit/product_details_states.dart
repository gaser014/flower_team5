part of 'product_details_cubit.dart';

// ProductDetailsCubit uses BaseState<ProductEntity> directly.
// States:
//   BaseState.initial()  — not yet loaded
//   BaseState.loading()  — fetching from API
//   BaseState.success(product) — product loaded
//   BaseState.error(exception) — fetch failed
