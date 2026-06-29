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

class AddressesBody extends StatefulWidget {
  const AddressesBody({super.key});

  @override
  State<AddressesBody> createState() => _AddressesBodyState();
}

class _AddressesBodyState extends State<AddressesBody> {
  late final AddressesCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<AddressesCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddressesCubit, AddressesStates>(
      buildWhen: (previous, current) =>
          previous.getAddressesState != current.getAddressesState ||
          previous.deleteAddressState != current.deleteAddressState,
      builder: (context, state) {
        final listState = state.getAddressesState;

        if (listState.isLoading || listState.isInitial) {
          return const AddressesShimmer();
        }

        if (listState.isError) {
          return AddressErrorState(
            message:
                listState.exception?.toString() ??
                AppStrings.somethingWentWrong,
            onRetry: () => _cubit.doIntent(const GetAddressesEvent()),
          );
        }

        final items = listState.data ?? [];
        return AddressListContent(
          items: items,
          isDeleting: state.deleteAddressState.isLoading,

          onEdit: (address) => context.pushNamed(
            Routes.addAddress,
            extra: {"editAddress": address, 'cubit': _cubit},
          ),
          onDelete: (id) => _confirmDelete(context, id),
          onAdd: () =>
              context.pushNamed(Routes.addAddress, extra: {'cubit': _cubit}),
        );
      },
    );
  }

  Future<void> _confirmDelete(BuildContext context, String addressId) async {
    await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => BlocProvider<AddressesCubit>.value(
        value: _cubit,
        child: DeleteAddressSheet(addressId: addressId),
      ),
    );
  }
}
