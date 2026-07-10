import 'package:flutter/material.dart';

import '../../values/app_colors.dart';

class SelectionItem {
  final String id;
  final String label;

  const SelectionItem({required this.id, required this.label});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SelectionItem && id == other.id;

  @override
  int get hashCode => id.hashCode;
}

Future<T?> showSelectionBottomSheet<T extends SelectionItem>({
  required BuildContext context,
  required String title,
  required List<T> items,
  String? selectedId,
  String? emptyMessage,
}) {
  return showModalBottomSheet<T>(
    context: context,
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (_) => _SelectionSheetContent<T>(
      title: title,
      items: items,
      selectedId: selectedId,
      emptyMessage: emptyMessage,
    ),
  );
}

class _SelectionSheetContent<T extends SelectionItem> extends StatelessWidget {
  final String title;
  final List<T> items;
  final String? selectedId;
  final String? emptyMessage;

  const _SelectionSheetContent({
    required this.title,
    required this.items,
    this.selectedId,
    this.emptyMessage,
  });

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      minChildSize: 0.3,
      maxChildSize: 0.8,
      expand: false,
      builder: (_, scrollController) => Column(
        children: [
          _buildHeader(context),
          const Divider(height: 1),
          Expanded(child: _buildList(context, scrollController)),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Text(title, style: Theme.of(context).textTheme.titleMedium),
    );
  }

  Widget _buildList(BuildContext context, ScrollController scrollController) {
    if (items.isNotEmpty) {
      return ListView.separated(
        controller: scrollController,
        itemCount: items.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (_, index) => _ItemTile<T>(
          item: items[index],
          isSelected: items[index].id == selectedId,
        ),
      );
    }

    return Center(
      child: Text(
        emptyMessage ?? 'No items',
        style: TextStyle(color: Theme.of(context).disabledColor),
      ),
    );
  }
}

class _ItemTile<T extends SelectionItem> extends StatelessWidget {
  final T item;
  final bool isSelected;

  const _ItemTile({required this.item, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(item.label),
      trailing: isSelected
          ? const Icon(Icons.check_circle, color: AppColors.green0C)
          : null,
      onTap: () => Navigator.pop(context, item),
    );
  }
}
