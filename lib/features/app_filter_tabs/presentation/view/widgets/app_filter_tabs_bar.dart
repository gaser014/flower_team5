import 'package:flowers_app/core/widgets/list_filter_tabs.dart';
import 'package:flowers_app/features/app_filter_tabs/domain/entities/app_filter_tab_item_entity.dart';
import 'package:flowers_app/features/app_filter_tabs/presentation/view_model/cubit/app_filter_tabs_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppFilterTabsBar extends StatelessWidget {
  final void Function(AppFilterTabItemEntity item) onTap;

  const AppFilterTabsBar({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppFilterTabsCubit, AppFilterTabsStates>(
      buildWhen: (previous, current) =>
          previous.categoriesState != current.categoriesState,
      builder: (context, state) {
        return ListFilterTabs(
          onTap: onTap,

          selectedItem: context.select(
            (AppFilterTabsCubit cubit) => cubit.state.selectCategoryState,
          ),
          state: state.categoriesState,
        );
      },
    );
  }
}
