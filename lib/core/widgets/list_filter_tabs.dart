import 'package:flowers_app/config/base_state/pagination_state.dart';
import 'package:flowers_app/core/widgets/filter_tabs.dart';
import 'package:flowers_app/features/app_filter_tabs/domain/entities/app_filter_tab_item_entity.dart';
import 'package:flutter/material.dart';

class ListFilterTabs<T extends AppFilterTabItemEntity> extends StatefulWidget {
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
  State<ListFilterTabs<T>> createState() => _ListFilterTabsState<T>();
}

class _ListFilterTabsState<T extends AppFilterTabItemEntity>
    extends State<ListFilterTabs<T>> {
  final ScrollController _scrollController = ScrollController();
  final List<GlobalKey> _keys = [];

  @override
  void initState() {
    super.initState();
    if (widget.selectedItem != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToSelected();
      });
    }
  }

  @override
  void didUpdateWidget(covariant ListFilterTabs<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    final isSuccess = widget.state.state == PaginationStateType.success;
    final wasSuccess = oldWidget.state.state == PaginationStateType.success;
    final selectedChanged = oldWidget.selectedItem != widget.selectedItem;

    if (isSuccess && (selectedChanged || !wasSuccess)) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToSelected();
      });
    }
  }

  void _scrollToSelected() {
    final index = widget.state.data.indexOf(widget.selectedItem as T);
    if (index == -1 || index >= _keys.length) return;

    final keyContext = _keys[index].currentContext;
    if (keyContext != null) {
      Scrollable.ensureVisible(
        keyContext,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
        alignment: 16 / 375,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.state.state) {
      case PaginationStateType.loading:
        return _ListViewSeparated(controller: _scrollController);

      case PaginationStateType.success:
        if (_keys.length != widget.state.data.length) {
          _keys.clear();
          _keys.addAll(
            List.generate(widget.state.data.length, (index) => GlobalKey()),
          );
        }
        return _ListViewSeparated(
          controller: _scrollController,
          itemBuilder: (context, index) {
            final item = widget.state.data[index];
            return FilterTab(
              key: _keys[index],
              label: item.name ?? '',
              isSelected: item == widget.selectedItem,
              onTap: () => widget.onTap(item),
            );
          },
          itemCount: widget.state.data.length,
        );

      default:
        return const SizedBox();
    }
  }
}

class _ListViewSeparated extends StatelessWidget {
  final Widget? Function(BuildContext, int)? itemBuilder;
  final int itemCount;
  final ScrollController? controller;

  const _ListViewSeparated({
    super.key,
    this.itemBuilder,
    this.itemCount = 8,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 72,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        controller: controller,
        separatorBuilder: (context, index) => const SizedBox(width: 24),
        padding: EdgeInsets.all(16),
        itemCount: itemCount,
        itemBuilder: itemBuilder ?? (context, index) => FilterTabShimmer(),
      ),
    );
  }
}
