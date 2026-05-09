import 'package:flowers_app/config/dependency_injection/di.dart';
import 'package:flowers_app/core/values/app_assets.dart';
import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/core/values/app_font_style.dart';
import 'package:flowers_app/core/values/app_strings.dart';
import 'package:flowers_app/core/widgets/text_field/custom_search_field.dart';
import 'package:flowers_app/features/categories/domain/entities/categories_params.dart';
import 'package:flowers_app/features/categories/presentation/view/widgets/categories_tap_bar.dart';
import 'package:flowers_app/features/categories/presentation/view_model/cubit/categories_cubit.dart';
import 'package:flowers_app/features/products/domain/entities/products_params.dart';
import 'package:flowers_app/features/products/presentation/view/pages/search_page.dart';
import 'package:flowers_app/features/products/presentation/view/widgets/products_body.dart';
import 'package:flowers_app/features/products/presentation/view/widgets/sort_bottom_sheet.dart';
import 'package:flowers_app/features/products/presentation/view_model/cubit/products_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  late final CategoriesCubit categoriesCubit;
  late final ProductsCubit productsCubit;
  SortOption _selectedSort = SortOption.newest;

  @override
  void initState() {
    super.initState();
    categoriesCubit = getIt<CategoriesCubit>()
      ..doIntent(
        GetAllCategoriesEvent(
          params: CategoriesParams(type: CategoriesType.occasions),
        ),
      );
    productsCubit = getIt<ProductsCubit>();

    // Listen for the initial category selection
    categoriesCubit.stream.firstWhere(
      (state) => state.selectCategoryState != null,
    ).then((state) {
      final category = state.selectCategoryState;
      if (category != null) {
        productsCubit.doIntent(
          GetAllProductsEvent(
            params: ProductsParams(
              category: category.id != null ? category : null,
              type: CategoriesType.occasions,
            ),
          ),
        );
      }
    });
  }

  String _getSortKey(SortOption option) {
    switch (option) {
      case SortOption.lowestPrice:
        return 'price';
      case SortOption.highestPrice:
        return '-price';
      case SortOption.newest:
        return '-createdAt';
      case SortOption.oldest:
        return 'createdAt';
      case SortOption.discount:
        return '-discount';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
                  child: Text(
                    'Categories',
                    style: AppFontStyle.medium20(context: context).copyWith(
                      color: AppColors.black0C,
                    ),
                  ),
                ),

                // Search bar + Sort button
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomSearchField(
                          readOnly: true,
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const SearchPage(),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 8),
                      _SortButton(
                        onTap: () => _showSortBottomSheet(context),
                      ),
                    ],
                  ),
                ),

                // Category tabs
                BlocProvider<CategoriesCubit>.value(
                  value: categoriesCubit,
                  child: BlocListener<CategoriesCubit, CategoriesStates>(
                    listenWhen: (previous, current) =>
                        previous.selectCategoryState !=
                        current.selectCategoryState,
                    listener: (context, state) {
                      final category = state.selectCategoryState;
                      if (category != null) {
                        productsCubit.doIntent(
                          GetAllProductsEvent(
                            params: ProductsParams(
                              category: category.id != null ? category : null,
                              type: CategoriesType.occasions,
                            ),
                          ),
                        );
                      }
                    },
                    child: CategoriesTapBar(
                      onTap: (item) {
                        categoriesCubit.doIntent(
                          SelectCategoryEvent(category: item),
                        );
                      },
                    ),
                  ),
                ),

                // Products grid
                Expanded(
                  child: BlocProvider<ProductsCubit>.value(
                    value: productsCubit,
                    child: const ProductsBody(),
                  ),
                ),
              ],
            ),

            // Floating filter button
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Center(
                child: _FloatingFilterButton(
                  onTap: () => _showSortBottomSheet(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSortBottomSheet(BuildContext context) async {
    final result = await showModalBottomSheet<SortOption>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => SortBottomSheet(initialOption: _selectedSort),
    );

    if (result != null && result != _selectedSort) {
      setState(() {
        _selectedSort = result;
      });

      final category = categoriesCubit.state.selectCategoryState;
      productsCubit.doIntent(
        GetAllProductsEvent(
          params: ProductsParams(
            category: category,
            type: CategoriesType.occasions,
            sort: _getSortKey(_selectedSort),
          ),
        ),
      );
    }
  }
}

class _SortButton extends StatelessWidget {
  final VoidCallback onTap;
  const _SortButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.whiteF9,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.grayA6, width: 0.5),
        ),
        child: SvgPicture.asset(
          AppAssets.iconsFilter,
          width: 20,
          height: 20,
          colorFilter: const ColorFilter.mode(
            AppColors.grayA6,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}

class _FloatingFilterButton extends StatelessWidget {
  final VoidCallback onTap;
  const _FloatingFilterButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: AppColors.primerColor,
          borderRadius: BorderRadius.circular(100),
          boxShadow: [
            BoxShadow(
              color: AppColors.primerColor.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              AppAssets.iconsFilter,
              width: 18,
              height: 18,
              colorFilter: const ColorFilter.mode(
                AppColors.white,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: 8),
            Text(
              AppStrings.filter,
              style: AppFontStyle.medium14(context: context).copyWith(
                color: AppColors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
