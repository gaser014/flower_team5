import 'package:flutter/material.dart';

import 'package:flowers_app/features/addresses/domain/entities/address_entity.dart';
import 'package:flowers_app/features/addresses/presentation/widgets/add_address_button.dart';
import 'package:flowers_app/features/addresses/presentation/widgets/address_list_view.dart';

class AddressListContent extends StatelessWidget {
  final List<AddressEntity> items;
  final bool isDeleting;
  final void Function(AddressEntity) onEdit;
  final void Function(String) onDelete;
  final VoidCallback onAdd;

  const AddressListContent({
    super.key,
    required this.items,
    required this.isDeleting,
    required this.onEdit,
    required this.onDelete,
    required this.onAdd,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: AddressListView(
            items: items,
            isDeleting: isDeleting,
            onEdit: onEdit,
            onDelete: onDelete,
          ),
        ),
        AddAddressButton(onAdd: onAdd),
      ],
    );
  }
}
