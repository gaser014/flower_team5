import 'package:flowers_app/config/base_state/pagination_state.dart';
import 'package:flowers_app/config/base_state/state_types.dart';
import 'package:flowers_app/core/widgets/filter_tabs.dart';
import 'package:flowers_app/core/widgets/loading_indicator.dart';
import 'package:flowers_app/features/categories/domain/entities/category_entity.dart';
import 'package:flutter/material.dart';

class ListFilterTabs extends StatelessWidget {
  final PaginationState<CategoryEntity> state;
  final CategoryEntity? selectedItem;

  final void Function(CategoryEntity item) onTap;

  const ListFilterTabs({
    super.key,
    required this.state,
    required this.onTap,
    required this.selectedItem,
  });

  @override
  Widget build(BuildContext context) {
    switch (state.state) {
      case PaginationStateType.loading:
        return SizedBox(height: 72, child: Center(child: LoadingIndicator()));
      case PaginationStateType.success:
        return SizedBox(
          height: 72,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,

            separatorBuilder: (context, index) => const SizedBox(width: 24),
            padding: EdgeInsets.all(16),
            itemCount: state.data.length,
            itemBuilder: (context, index) {
              final item = state.data[index];
              return FilterTab(
                label: item.name ?? '',
                isSelected: item == selectedItem,
                onTap: () => onTap(item),
              );
            },
          ),
        );
      default:
        return const SizedBox();
    }
  }
}
