import 'package:flowers_app/core/values/app_assets.dart';
import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/core/values/app_font_style.dart';
import 'package:flowers_app/core/values/app_strings.dart';
import 'package:flowers_app/features/home/presentation/categories/presentation/view/widgets/categories_tap_bar.dart';
import 'package:flowers_app/features/home/presentation/categories/presentation/view_model/cubit/categories_cubit.dart';
import 'package:flowers_app/config/dependency_injection/di.dart';
import 'package:flowers_app/core/widgets/pagination_grid_view.dart';
import 'package:flowers_app/features/home/presentation/categories/presentation/view/widgets/sort_by_bottom_sheet.dart';
import 'package:flowers_app/features/home/presentation/categories/presentation/view/categories_search_screen.dart';
import 'package:flowers_app/config/uses_cases/filter_param.dart';
import 'package:flowers_app/features/home/presentation/categories/domain/entities/categories_params.dart';
import 'package:flowers_app/features/home/presentation/categories/presentation/view/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class CategoriesView extends StatelessWidget {
  const CategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<CategoriesCubit>()..doIntent(const GetAllCategoriesEvent()),
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
                  Expanded(
                    child: _buildProductGrid(context),
                  ),
                ],
              ),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
            floatingActionButton: _buildFloatingFilterButton(context),
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
                        cubit: context.read<CategoriesCubit>(),
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
                        style: AppFontStyle.regular14(context: context).copyWith(
                          color: AppColors.grayA6,
                        ),
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
      },
    );
  }

  Widget _buildProductGrid(BuildContext context) {
    return BlocBuilder<CategoriesCubit, CategoriesStates>(
      builder: (context, state) {
        return PaginationGridView<dynamic>(
          items: state.categoriesState.data,
          isLoading: state.categoriesState.isLoading,
          isLoadingMore: state.categoriesState.isLoadingMore,
          hasMore: state.categoriesState.hasMore,
          itemBuilder: (context, item, index) {
            return const SizedBox.shrink();
          },
          onLoadMore: () {
             context.read<CategoriesCubit>().doIntent(
              LoadMoreCategoriesEvent(params: state.categoriesState.query as CategoriesParams),
            );
          },
          onRefresh: () => context.read<CategoriesCubit>().refreshCategories(),
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
          colorFilter: const ColorFilter.mode(
            AppColors.white,
            BlendMode.srcIn,
          ),
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
    final cubit = context.read<CategoriesCubit>();
    final currentParams = cubit.state.categoriesState.query as CategoriesParams;
    final currentSortBy = currentParams.filterList
        .firstWhere((f) => f.key == 'sort_by', orElse: () => const FilterParam(key: 'sort_by', value: ''))
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
