import 'package:flowers_app/core/widgets/pagination_grid_view.dart';
import 'package:flowers_app/features/products/domain/entities/product_entity.dart';
import 'package:flowers_app/features/products/domain/entities/products_params.dart';
import 'package:flowers_app/features/products/presentation/view/widgets/empty_products_widget.dart';
import 'package:flowers_app/core/widgets/product_card.dart';
import 'package:flowers_app/features/products/presentation/view/widgets/products_shimmer.dart';
import 'package:flowers_app/features/products/presentation/view_model/cubit/products_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsBody extends StatefulWidget {
  const ProductsBody({super.key});

  @override
  State<ProductsBody> createState() => _ProductsBodyState();
}

class _ProductsBodyState extends State<ProductsBody> {
  late final ProductsCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = context.read<ProductsCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsStates>(
      builder: (context, state) {
        final ps = state.productsState;
        return PaginationGridView<ProductEntity>(
          items: ps.data,
          isLoading: ps.isLoading || ps.isInitial,
          isLoadingMore: ps.isLoadingMore,
          isAlwaysScrollable: true,
          hasMore: ps.hasMore,
          onLoadMore: () => cubit.doIntent(
            LoadMoreProductsEvent(
              params:
                  ps.query.copyWith(page: ps.currentPage + 1) as ProductsParams,
            ),
          ),
          onRefresh: cubit.refreshProducts,
          shimmerBuilder: (context, index) => const _ShimmerItem(),
          emptyWidget: const EmptyProductsWidget(),
          padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
          itemBuilder: (context, item, index) => ProductCard(product: item),
        );
      },
    );
  }
}

class _ShimmerItem extends StatelessWidget {
  const _ShimmerItem();

  @override
  Widget build(BuildContext context) => const ProductsShimmer();
}
