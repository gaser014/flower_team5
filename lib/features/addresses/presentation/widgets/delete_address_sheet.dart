import 'package:flowers_app/core/values/app_strings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/core/values/app_font_style.dart';
import 'package:flowers_app/features/addresses/presentation/cubit/addresses_cubit.dart';
import 'package:go_router/go_router.dart';

class DeleteAddressSheet extends StatefulWidget {
  final String addressId;
  const DeleteAddressSheet({super.key, required this.addressId});

  @override
  State<DeleteAddressSheet> createState() => _DeleteAddressSheetState();
}

class _DeleteAddressSheetState extends State<DeleteAddressSheet> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddressesCubit, AddressesStates>(
      listenWhen: (previous, current) =>
          previous.deleteAddressState.isLoading &&
          !current.deleteAddressState.isLoading,
      listener: (context, state) => context.pop(),
      builder: (context, state) {
        final isLoading = state.deleteAddressState.isLoading;
        return Padding(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                AppStrings.deleteAddressTitle,
                style: AppFontStyle.medium20(context: context),
              ),
              const SizedBox(height: 16),
              Text(
                AppStrings.deleteAddressMessage,
                style: AppFontStyle.regular14(
                  context: context,
                ).copyWith(color: AppColors.gray53),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              Row(
                spacing: 16,
                children: [
                  if (!isLoading)
                    Expanded(
                      child: _SheetButton(
                        label: AppStrings.cancel,

                        onPressed: isLoading ? () {} : () => context.pop(),
                      ),
                    ),
                  Expanded(
                    child: _SheetButton(
                      label: AppStrings.delete,
                      isLoading: isLoading,
                      backgroundColor: AppColors.redCC,
                      foregroundColor: AppColors.whiteF9,
                      onPressed: () => context.read<AddressesCubit>().doIntent(
                        DeleteAddressEvent(id: widget.addressId),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _SheetButton extends StatelessWidget {
  final String label;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final VoidCallback? onPressed;
  final bool isLoading;

  const _SheetButton({
    required this.label,
    this.backgroundColor,
    this.foregroundColor,
    required this.onPressed,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? AppColors.whiteF9,
        foregroundColor: foregroundColor ?? AppColors.black0C,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: backgroundColor != null
              ? BorderSide.none
              : const BorderSide(color: AppColors.gray53),
        ),
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: 14),
      ),
      child: isLoading
          ? const Center(
              child: CupertinoActivityIndicator(color: AppColors.white),
            )
          : Text(label, style: AppFontStyle.medium16(context: context)),
    );
  }
}
