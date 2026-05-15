import 'package:flowers_app/core/values/app_assets.dart';
import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/core/values/app_font_style.dart';
import 'package:flowers_app/core/values/app_strings.dart';
import 'package:flowers_app/features/categories/domain/entities/categories_params.dart';
import 'package:flowers_app/features/categories/presentation/view_model/cubit/categories_cubit.dart';
import 'package:flowers_app/core/widgets/pagination_grid_view.dart';
import 'package:flowers_app/features/categories/presentation/view/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class CategoriesSearchScreen extends StatefulWidget {
  final CategoriesCubit cubit;

  const CategoriesSearchScreen({super.key, required this.cubit});

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
      value: widget.cubit,
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SafeArea(
          child: Column(
            children: [
              _buildSearchBar(context),
              Expanded(child: _buildBody(context)),
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
                  widget.cubit.doIntent(SearchCategoriesEvent(query: value));
                },
                decoration: InputDecoration(
                  hintText: AppStrings.search,
                  hintStyle: AppFontStyle.regular14(
                    context: context,
                  ).copyWith(color: AppColors.grayA6),
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
                          icon: const Icon(
                            Icons.close,
                            color: AppColors.grayA6,
                          ),
                          onPressed: () {
                            _searchController.clear();
                            widget.cubit.doIntent(
                              const SearchCategoriesEvent(query: ''),
                            );
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
    return BlocBuilder<CategoriesCubit, CategoriesStates>(
      builder: (context, state) {
        final query = _searchController.text;

        if (query.isEmpty) {
          return Center(
            child: Text(
              AppStrings.searchForAnyProduct,
              style: AppFontStyle.medium16(
                context: context,
              ).copyWith(color: AppColors.primerColor),
            ),
          );
        }

        return PaginationGridView<dynamic>(
          items: state.categoriesState.data,
          isLoading: state.categoriesState.isLoading,
          isLoadingMore: state.categoriesState.isLoadingMore,
          hasMore: state.categoriesState.hasMore,
          itemBuilder: (context, item, index) {
            return ProductCard(product: item);
          },
          onLoadMore: () {
            widget.cubit.doIntent(
              LoadMoreCategoriesEvent(
                params: state.categoriesState.query as CategoriesParams,
              ),
            );
          },
          onRefresh: () => widget.cubit.refreshCategories(),
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
