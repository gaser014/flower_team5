import 'package:flowers_app/core/widgets/list_filter_tabs.dart';
import '../../../domain/entities/category_entity.dart';
import '../../view_model/cubit/categories_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flowers_app/config/base_state/pagination_state.dart';


class CategoriesTapBar extends StatelessWidget {
  final void Function(CategoryEntity item) onTap;

  const CategoriesTapBar({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesCubit, CategoriesStates>(
      buildWhen: (previous, current) =>
          previous.categoriesState != current.categoriesState ||
          previous.selectCategoryState != current.selectCategoryState,
      builder: (context, state) {
        final List<CategoryEntity> allCategories = [
          const CategoryEntity(id: null, name: 'All'),
          ...state.categoriesState.data,
        ];

        final modifiedState = PaginationState<CategoryEntity>(
          state: state.categoriesState.state,
          data: allCategories,
          meta: state.categoriesState.meta,
          exception: state.categoriesState.exception,
          query: state.categoriesState.query,
        );

        return ListFilterTabs(
          onTap: onTap,
          selectedItem: state.selectCategoryState,
          state: modifiedState,
        );
      },
    );
  }
}
