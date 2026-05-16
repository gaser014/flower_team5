import 'package:flowers_app/core/values/app_assets.dart';
import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/core/values/app_font_style.dart';
import 'package:flowers_app/core/values/app_strings.dart';
import 'package:flowers_app/features/products/presentation/view/widgets/product_card.dart';
import 'package:flowers_app/features/products/presentation/view/widgets/product_card_shimmer.dart';
import 'widgets/categories_tap_bar.dart';
import '../view_model/cubit/categories_cubit.dart' hide UpdateSortByEvent;
import 'package:flowers_app/config/dependency_injection/di.dart';
import 'package:flowers_app/core/widgets/pagination_grid_view.dart';
import 'widgets/sort_by_bottom_sheet.dart';
import 'categories_search_screen.dart';
import 'package:flowers_app/config/uses_cases/filter_param.dart';

import 'package:flowers_app/features/products/presentation/view_model/cubit/products_cubit.dart';
import 'package:flowers_app/features/products/domain/entities/products_params.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class CategoriesView extends StatelessWidget {
  const CategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              getIt<CategoriesCubit>()..doIntent(const GetAllCategoriesEvent()),
        ),
        BlocProvider(
          create: (context) =>
              getIt<ProductsCubit>()..doIntent(const GetAllProductsEvent()),
        ),
      ],
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: AppColors.white,
            body: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSearchBar(context),
                  const Gap(8),
                  _buildCategoriesList(context),
                  Expanded(child: _buildProductGrid(context)),
                ],
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: BlocBuilder<ProductsCubit, ProductsStates>(
              builder: (context, state) {
                final currentParams = state.productsState.query as ProductsParams;
                final hasSortFilter = currentParams.filterList.any(
                  (f) => f.key == 'sort' && f.value.toString().isNotEmpty,
                );
                
                if (hasSortFilter) {
                  return _buildFloatingFilterButton(context);
                }
                return const SizedBox.shrink();
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: Builder(
              builder: (context) => GestureDetector(
                onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => CategoriesSearchScreen(
                          productsCubit: context.read<ProductsCubit>(),
                        ),
                      ),
                    );
                },
                child: Container(
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppColors.whiteF9,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.grayEA),
                  ),
                  child: Row(
                    children: [
                      const Gap(12),
                      SvgPicture.asset(
                        AppAssets.iconsSearch,
                        colorFilter: const ColorFilter.mode(
                          AppColors.grayA6,
                          BlendMode.srcIn,
                        ),
                      ),
                      const Gap(8),
                      Text(
                        AppStrings.search,
                        style: AppFontStyle.regular14(
                          context: context,
                        ).copyWith(color: AppColors.grayA6),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const Gap(12),
          _buildFilterIconButton(context),
        ],
      ),
    );
  }

  Widget _buildFilterIconButton(BuildContext context) {
    return Builder(
      builder: (context) => Container(
        height: 48,
        width: 48,
        decoration: BoxDecoration(
          color: AppColors.whiteF9,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.grayEA),
        ),
        child: IconButton(
          icon: SvgPicture.asset(
            AppAssets.iconsFilter,
            colorFilter: const ColorFilter.mode(
              AppColors.grayA6,
              BlendMode.srcIn,
            ),
          ),
          onPressed: () => _showSortBottomSheet(context),
        ),
      ),
    );
  }

  Widget _buildCategoriesList(BuildContext context) {
    return CategoriesTapBar(
      onTap: (category) {
        context.read<CategoriesCubit>().doIntent(
              SelectCategoryEvent(category: category),
            );
        context.read<ProductsCubit>().doIntent(
              GetAllProductsEvent(
                params: ProductsParams(
                  category: category,
                  page: 1,
                ),
              ),
            );
      },
    );
  }

  Widget _buildProductGrid(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsStates>(
      builder: (context, state) {
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
            context.read<ProductsCubit>().doIntent(
                  LoadMoreProductsEvent(
                    params: state.productsState.query as ProductsParams,
                  ),
                );
          },
          onRefresh: () => context.read<ProductsCubit>().refreshProducts(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
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

  Widget _buildFloatingFilterButton(BuildContext context) {
    return Builder(
      builder: (context) => ElevatedButton.icon(
        onPressed: () => _showSortBottomSheet(context),
        icon: SvgPicture.asset(
          AppAssets.iconsFilter,
          colorFilter: const ColorFilter.mode(AppColors.white, BlendMode.srcIn),
          height: 20,
        ),
        label: const Text('Filter'),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primerColor,
          foregroundColor: AppColors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
        ),
      ),
    );
  }

  void _showSortBottomSheet(BuildContext context) {
    final cubit = context.read<ProductsCubit>();
    final currentParams = cubit.state.productsState.query as ProductsParams;
    final currentSortBy = currentParams.filterList
        .firstWhere(
          (f) => f.key == 'sort',
          orElse: () => const FilterParam(key: 'sort', value: ''),
        )
        .value;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => SortByBottomSheet(
        selectedSortBy: currentSortBy,
        onSortSelected: (sortBy) {
          cubit.doIntent(UpdateSortByEvent(sortBy: sortBy));
        },
      ),
    );
  }
}
