import 'dart:async';

import 'package:flowers_app/config/dependency_injection/di.dart';
import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/core/values/app_font_style.dart';
import 'package:flowers_app/core/values/app_strings.dart';
import 'package:flowers_app/core/widgets/text_field/custom_search_field.dart';
import 'package:flowers_app/features/categories/domain/entities/categories_params.dart';
import 'package:flowers_app/features/products/domain/entities/products_params.dart';
import 'package:flowers_app/features/products/presentation/view/widgets/products_body.dart';
import 'package:flowers_app/features/products/presentation/view_model/cubit/products_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _searchController = TextEditingController();
  late final ProductsCubit _productsCubit;
  Timer? _debounce;
  bool _hasSearched = false;

  @override
  void initState() {
    super.initState();
    _productsCubit = getIt<ProductsCubit>();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged() {
    final query = _searchController.text.trim();

    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (query.isNotEmpty) {
        setState(() => _hasSearched = true);
        _productsCubit.doIntent(
          SearchProductsEvent(
            params: ProductsParams(
              keyword: query,
              type: CategoriesType.occasions,
              clearCategory: true,
            ),
          ),
        );
      } else {
        setState(() => _hasSearched = false);
        _productsCubit.reset();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
              child: Text(
                'Search',
                style: AppFontStyle.medium20(context: context).copyWith(
                  color: AppColors.black0C,
                ),
              ),
            ),

            // Search field + close button
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
              child: Row(
                children: [
                  Expanded(
                    child: CustomSearchField(
                      controller: _searchController,
                      onClear: () {
                        _searchController.clear();
                        setState(() => _hasSearched = false);
                      },
                      autofocus: true,
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      Icons.cancel_outlined,
                      color: AppColors.grayA6,
                      size: 28,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: _hasSearched
                  ? BlocProvider<ProductsCubit>.value(
                      value: _productsCubit,
                      child: const ProductsBody(),
                    )
                  : Center(
                      child: Text(
                        AppStrings.searchForAnyProduct,
                        style: AppFontStyle.medium14(context: context).copyWith(
                          color: AppColors.primerColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
