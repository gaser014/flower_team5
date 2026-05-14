import 'package:flowers_app/core/widgets/list_filter_tabs.dart';
import 'package:flowers_app/features/categories/domain/entities/category_entity.dart';
import 'package:flowers_app/features/categories/presentation/view_model/cubit/categories_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


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
        return ListFilterTabs(
          onTap: onTap,
          selectedItem: state.selectCategoryState,
          state: state.categoriesState,
        );
      },
    );
  }
}
