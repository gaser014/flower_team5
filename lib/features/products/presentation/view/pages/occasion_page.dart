import 'package:flowers_app/config/dependency_injection/di.dart';
import 'package:flowers_app/core/values/app_assets.dart';
import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/core/values/app_font_style.dart';
import 'package:flowers_app/core/values/app_strings.dart';
import 'package:flowers_app/core/widgets/custom_app_bar.dart';
import 'package:flowers_app/features/app_filter_tabs/domain/entities/app_filter_tab_item_entity.dart';
import 'package:flowers_app/features/app_filter_tabs/domain/entities/app_filter_tabs_params.dart';
import 'package:flowers_app/features/app_filter_tabs/presentation/view/widgets/app_filter_tabs_bar.dart';
import 'package:flowers_app/features/app_filter_tabs/presentation/view_model/cubit/app_filter_tabs_cubit.dart';
import 'package:flowers_app/features/products/domain/entities/products_params.dart';
import 'package:flowers_app/features/products/presentation/view/widgets/products_body.dart';
import 'package:flowers_app/features/products/presentation/view_model/cubit/products_cubit.dart';
import 'package:flowers_app/features/products/presentation/view/pages/products_search_screen.dart';
import 'package:flowers_app/features/products/presentation/view/widgets/sort_by_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class OccasionPage extends StatefulWidget {
  final AppFilterTabItemEntity? occasion;

  const OccasionPage({super.key, this.occasion});

  @override
  State<OccasionPage> createState() => _OccasionPageState();
}

class _OccasionPageState extends State<OccasionPage> {
  late final AppFilterTabsCubit appFilterTabsCubit;
  late final ProductsCubit productsCubit;

  @override
  void initState() {
    appFilterTabsCubit = getIt<AppFilterTabsCubit>();
    appFilterTabsCubit.doIntent(
      GetAllAppFilterTabsEvent(
        params: AppFilterTabsParams(type: AppFilterTabsType.occasions),
        selectedTabFilter: widget.occasion,
      ),
    );
    productsCubit = getIt<ProductsCubit>();
    if (widget.occasion != null) {
      productsCubit.doIntent(
        GetAllProductsEvent(
          params: ProductsParams(
            category: widget.occasion,
            type: AppFilterTabsType.occasions,
          ),
        ),
      );
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ProductsCubit>.value(
      value: productsCubit,
      child: Scaffold(
        appBar: CustomAppBar(
          title: AppStrings.occasion,
          subTitle: AppStrings.occasionSubTitle,
        ),
        body: SafeArea(
          child: ProductWithTabFilter(
            appFilterTabsCubit: appFilterTabsCubit,
            productsCubit: productsCubit,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: _buildFloatingFilterButton(context),
      ),
    );
  }

  Widget _buildFloatingFilterButton(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsStates>(
      builder: (context, state) {
        final currentParams = state.productsState.query;
        final hasFilter =
            currentParams is ProductsParams && currentParams.sortType != null;

        if (!hasFilter) return const SizedBox.shrink();

        return ElevatedButton.icon(
          onPressed: () => _showSortBottomSheet(context),
          icon: SvgPicture.asset(
            AppAssets.iconsFilter,
            colorFilter:
                const ColorFilter.mode(AppColors.white, BlendMode.srcIn),
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
        );
      },
    );
  }

  void _showSortBottomSheet(BuildContext context) {
    final currentParams = productsCubit.state.productsState.query as ProductsParams;
    final currentSortBy = currentParams.sortType ?? SortType.newProduct;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => SortByBottomSheet(
        selectedSortBy: currentSortBy,
        onSortSelected: (sortBy) {
          productsCubit.doIntent(UpdateSortByEvent(sortBy: sortBy));
        },
      ),
    );
  }
}

class ProductWithTabFilter extends StatelessWidget {
  final AppFilterTabsCubit appFilterTabsCubit;
  final ProductsCubit productsCubit;

  const ProductWithTabFilter({
    super.key,
    required this.appFilterTabsCubit,
    required this.productsCubit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSearchBar(context),
        const Gap(8),
        BlocProvider<AppFilterTabsCubit>.value(
          value: appFilterTabsCubit,
          child: BlocListener<AppFilterTabsCubit, AppFilterTabsStates>(
            listenWhen: (previous, current) =>
                previous.selectCategoryState != current.selectCategoryState,
            listener: (context, state) {
              final category = state.selectCategoryState;
              if (category != null) {
                productsCubit.doIntent(
                  GetAllProductsEvent(
                    params: ProductsParams(
                      category: category,
                      type: AppFilterTabsType.occasions,
                    ),
                  ),
                );
              }
            },
            child: AppFilterTabsBar(
              onTap: (item) {
                appFilterTabsCubit.doIntent(
                  SelectAppFilterTabEvent(category: item),
                );
              },
            ),
          ),
        ),
        Expanded(
          child: BlocProvider<ProductsCubit>.value(
            value: productsCubit,
            child: const ProductsBody(),
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ProductsSearchScreen(
                      productsCubit: productsCubit,
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
          const Gap(12),
          _buildFilterIconButton(context),
        ],
      ),
    );
  }

  Widget _buildFilterIconButton(BuildContext context) {
    return Container(
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
    );
  }

  void _showSortBottomSheet(BuildContext context) {
    final currentParams = productsCubit.state.productsState.query as ProductsParams;
    final currentSortBy = currentParams.sortType ?? SortType.newProduct;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => SortByBottomSheet(
        selectedSortBy: currentSortBy,
        onSortSelected: (sortBy) {
          productsCubit.doIntent(UpdateSortByEvent(sortBy: sortBy));
        },
      ),
    );
  }
}
