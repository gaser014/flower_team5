import 'package:flutter/material.dart';

import 'package:flowers_app/core/localization_constants/address_constants.dart';
import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/core/widgets/custom_button.dart';
import 'package:flowers_app/features/addresses/domain/entities/address_entity.dart';
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: CustomButton(
            text: context.addNewAddress,
            onPressed: onAdd,
            height: 50,
            radius: 20,
            backgroundColor: AppColors.primerColor,
            textColor: AppColors.whiteF9,
          ),
        ),
      ],
    );
  }
}
