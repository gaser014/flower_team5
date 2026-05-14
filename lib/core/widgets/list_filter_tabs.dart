import 'package:flowers_app/config/base_state/pagination_state.dart';
import 'package:flowers_app/config/base_state/state_types.dart';
import 'package:flowers_app/core/widgets/filter_tabs.dart';
import 'package:flowers_app/features/app_filter_tabs/domain/entities/app_filter_tab_item_entity.dart';
import 'package:flutter/material.dart';

class ListFilterTabs<T extends AppFilterTabItemEntity> extends StatelessWidget {
  final PaginationState<T> state;
  final T? selectedItem;

  final void Function(T item) onTap;

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
        return _ListViewSeparated();

      case PaginationStateType.success:
        return _ListViewSeparated(
          itemBuilder: (context, index) {
            final item = state.data[index];
            return FilterTab(
              label: item.name ?? '',
              isSelected: item == selectedItem,
              onTap: () => onTap(item),
            );
          },
          itemCount: state.data.length,
        );

      default:
        return const SizedBox();
    }
  }
}

class _ListViewSeparated extends StatelessWidget {
  final Widget? Function(BuildContext, int)? itemBuilder;
  final int itemCount;

  const _ListViewSeparated({super.key, this.itemBuilder, this.itemCount = 8});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 72,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,

        separatorBuilder: (context, index) => const SizedBox(width: 24),
        padding: EdgeInsets.all(16),
        itemCount: itemCount,
        itemBuilder: itemBuilder ?? (context, index) => FilterTabShimmer(),
      ),
    );
  }
}
