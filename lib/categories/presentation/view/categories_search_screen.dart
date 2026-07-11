import 'package:flowers_app/core/values/app_assets.dart';
import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/core/values/app_font_style.dart';
import 'package:flowers_app/core/values/app_strings.dart';
import 'package:flowers_app/features/products/presentation/view_model/cubit/products_cubit.dart';
import 'package:flowers_app/features/products/domain/entities/products_params.dart';
import 'package:flowers_app/core/widgets/pagination_grid_view.dart';
import 'package:flowers_app/features/products/presentation/view/widgets/product_card.dart';
import 'package:flowers_app/features/products/presentation/view/widgets/product_card_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class CategoriesSearchScreen extends StatefulWidget {
  final ProductsCubit productsCubit;

  const CategoriesSearchScreen({super.key, required this.productsCubit});

  @override
  State<CategoriesSearchScreen> createState() => _CategoriesSearchScreenState();
}

class _CategoriesSearchScreenState extends State<CategoriesSearchScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: widget.productsCubit,
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: Column(
            children: [
              _buildSearchBar(context),
              Expanded(
                child: _buildBody(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          IconButton(
            icon: SvgPicture.asset(AppAssets.arrowBack),
            onPressed: () => Navigator.pop(context),
          ),
          const Gap(8),
          Expanded(
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: AppColors.whiteF9,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.grayEA),
              ),
              child: TextField(
                controller: _searchController,
                autofocus: true,
                onChanged: (value) {
                  widget.productsCubit.doIntent(SearchProductsEvent(query: value));
                },
                decoration: InputDecoration(
                  hintText: AppStrings.search,
                  hintStyle: AppFontStyle.regular14(context: context).copyWith(
                    color: AppColors.grayA6,
                  ),
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(12),
                    child: SvgPicture.asset(
                      AppAssets.iconsSearch,
                      colorFilter: const ColorFilter.mode(
                        AppColors.grayA6,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: const Icon(Icons.close, color: AppColors.grayA6),
                          onPressed: () {
                            _searchController.clear();
                            widget.productsCubit.doIntent(const SearchProductsEvent(query: ''));
                            setState(() {});
                          },
                        )
                      : null,
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsStates>(
      builder: (context, state) {
        final query = _searchController.text;
        
        if (query.isEmpty) {
          return Center(
            child: Text(
              AppStrings.searchForAnyProduct,
              style: AppFontStyle.medium16(context: context).copyWith(
                color: AppColors.primerColor,
              ),
            ),
          );
        }

        return PaginationGridView<dynamic>(
          items: state.productsState.data,
          isLoading: state.productsState.isLoading,
          isLoadingMore: state.productsState.isLoadingMore,
          hasMore: state.productsState.hasMore,
          itemBuilder: (context, item, index) {
            return ProductCard(product: item);
          },
          shimmerBuilder: (context, index) => const ProductCardShimmer(),
          shimmerCount: 6,
          onLoadMore: () {
            widget.productsCubit.doIntent(
              LoadMoreProductsEvent(
                params: state.productsState.query as ProductsParams,
              ),
            );
          },
          onRefresh: () => widget.productsCubit.refreshProducts(),
          padding: const EdgeInsets.all(16),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 0.7,
          ),
        );
      },
    );
  }
}
