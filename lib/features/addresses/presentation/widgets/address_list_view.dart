import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flowers_app/features/addresses/domain/entities/address_entity.dart';
import 'package:flowers_app/features/addresses/presentation/cubit/addresses_cubit.dart';
import 'package:flowers_app/features/addresses/presentation/widgets/address_card.dart';
import 'package:flowers_app/features/addresses/presentation/widgets/empty_addresses_widget.dart';

class AddressListView extends StatelessWidget {
  final List<AddressEntity> items;
  final bool isDeleting;
  final void Function(AddressEntity) onEdit;
  final void Function(String) onDelete;

  const AddressListView({
    super.key,
    required this.items,
    required this.isDeleting,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const EmptyAddressesWidget();

    return RefreshIndicator(
      onRefresh: () async =>
          context.read<AddressesCubit>().doIntent(const GetAddressesEvent()),
      child: ListView.separated(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
        itemCount: items.length,
        separatorBuilder: (context, i) => const SizedBox(height: 16),
        itemBuilder: (context, index) {
          final address = items[index];
          return AddressCard(
            address: address,
            isDeleting: isDeleting,
            onEdit: () => onEdit(address),
            onDelete: () => onDelete(address.id ?? ''),
          );
        },
      ),
    );
  }
}
