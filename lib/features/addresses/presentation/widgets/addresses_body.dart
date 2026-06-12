import 'package:flowers_app/core/localization_constants/address_constants.dart';
import 'package:flowers_app/core/routes/routes.dart';
import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/core/values/app_strings.dart';
import 'package:flowers_app/features/addresses/domain/entities/address_entity.dart';
import 'package:flowers_app/features/addresses/presentation/cubit/addresses_cubit.dart';
import 'package:flowers_app/features/addresses/presentation/widgets/empty_addresses_widget.dart';
import 'package:flowers_app/features/addresses/presentation/widgets/address_card.dart';
import 'package:flowers_app/features/addresses/presentation/widgets/addresses_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AddressesBody extends StatelessWidget {
  const AddressesBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddressesCubit, AddressesStates>(
      builder: (context, state) {
        final listState = state.getAddressesState;

        if (listState.isLoading || listState.isInitial) {
          return const AddressesShimmer();
        }

        if (listState.isError) {
          return _ErrorState(
            message: listState.exception?.toString() ?? AppStrings.somethingWentWrong,
            onRetry: () =>
                context.read<AddressesCubit>().doIntent(const GetAddressesEvent()),
          );
        }

        final items = listState.data ?? [];
        return _AddressListContent(
          items: items,
          isDeleting: state.deleteAddressState.isLoading,
          onEdit: (address) =>
              context.pushNamed(Routes.addAddress, extra: address),
          onDelete: (id) => _confirmDelete(context, id),
          onAdd: () => context.pushNamed(Routes.addAddress),
        );
      },
    );
  }

  Future<void> _confirmDelete(BuildContext context, String addressId) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(context.deleteAddressTitle),
        content: Text(context.deleteAddressMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(context.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: TextButton.styleFrom(foregroundColor: AppColors.redCC),
            child: Text(context.delete),
          ),
        ],
      ),
    );

    if (confirmed == true && context.mounted) {
      context.read<AddressesCubit>().doIntent(
        DeleteAddressEvent(id: addressId),
      );
    }
  }
}

class _ErrorState extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorState({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(message),
          const SizedBox(height: 16),
          ElevatedButton(onPressed: onRetry, child: Text(AppStrings.tryAgain)),
        ],
      ),
    );
  }
}

class _AddressListContent extends StatelessWidget {
  final List<AddressEntity> items;
  final bool isDeleting;
  final void Function(AddressEntity) onEdit;
  final void Function(String) onDelete;
  final VoidCallback onAdd;

  const _AddressListContent({
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
        Expanded(child: _buildList(context)),
        _buildAddButton(context),
      ],
    );
  }

  Widget _buildList(BuildContext context) {
    if (items.isEmpty) return const EmptyAddressesWidget();

    return RefreshIndicator(
      onRefresh: () async =>
          context.read<AddressesCubit>().doIntent(const GetAddressesEvent()),
      child: ListView.builder(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
        itemCount: items.length,
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

  Widget _buildAddButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: onAdd,
          icon: const Icon(Icons.add_location_alt_outlined, size: 18),
          label: Text(context.addNewAddress),
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
        ),
      ),
    );
  }
}
