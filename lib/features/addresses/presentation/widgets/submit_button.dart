import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flowers_app/core/localization_constants/address_constants.dart';
import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/features/addresses/presentation/cubit/addresses_cubit.dart';

class SubmitButton extends StatelessWidget {
  final VoidCallback onSubmit;

  const SubmitButton({super.key, required this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddressesCubit, AddressesStates>(
      builder: (context, state) {
        final isLoading =
            state.addAddressState.isLoading ||
            state.updateAddressState.isLoading;

        return ElevatedButton(
          onPressed: isLoading ? null : onSubmit,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16),
            backgroundColor: AppColors.primerColor,
            foregroundColor: AppColors.white,
          ),
          child: isLoading
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: AppColors.white,
                  ),
                )
              : Text(context.saveAddress),
        );
      },
    );
  }
}
