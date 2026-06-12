import 'package:flowers_app/core/routes/routes.dart';
import 'package:flowers_app/core/values/app_strings.dart';
import 'package:flowers_app/features/addresses/presentation/cubit/addresses_cubit.dart';
import 'package:flowers_app/features/addresses/presentation/widgets/address_error_state.dart';
import 'package:flowers_app/features/addresses/presentation/widgets/address_list_content.dart';
import 'package:flowers_app/features/addresses/presentation/widgets/addresses_shimmer.dart';
import 'package:flowers_app/features/addresses/presentation/widgets/delete_address_sheet.dart';
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
          return AddressErrorState(
            message: listState.exception?.toString() ?? AppStrings.somethingWentWrong,
            onRetry: () =>
                context.read<AddressesCubit>().doIntent(const GetAddressesEvent()),
          );
        }

        final items = listState.data ?? [];
        return AddressListContent(
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
    final confirmed = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => const DeleteAddressSheet(),
    );

    if (confirmed == true && context.mounted) {
      context.read<AddressesCubit>().doIntent(
        DeleteAddressEvent(id: addressId),
      );
    }
  }
}
