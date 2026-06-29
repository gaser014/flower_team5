import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';

import 'package:flowers_app/core/localization_constants/address_constants.dart';
import 'package:flowers_app/core/location_data/egypt_location_loader.dart';
import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/core/widgets/custom_button.dart';
import 'package:flowers_app/core/widgets/text_field/phone_field.dart';
import 'package:flowers_app/features/addresses/presentation/widgets/address_text_field.dart';
import 'package:flowers_app/features/addresses/presentation/widgets/city_area_row.dart';
import 'package:flowers_app/features/addresses/presentation/widgets/map_preview.dart';
import 'package:flowers_app/features/addresses/presentation/cubit/addresses_cubit.dart';

class AddressForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;

  final TextEditingController streetController;
  final TextEditingController phoneController;
  final TextEditingController usernameController;
  final ValueChanged<GovernorateItem> onCityChanged;
  final ValueChanged<AreaItem?> onAreaChanged;
  final VoidCallback onPickLocation;
  final VoidCallback onSubmit;

  const AddressForm({
    super.key,
    required this.formKey,

    required this.streetController,
    required this.phoneController,
    required this.usernameController,
    required this.onCityChanged,
    required this.onAreaChanged,
    required this.onPickLocation,
    required this.onSubmit,
  });

  @override
  State<AddressForm> createState() => _AddressFormState();
}

class _AddressFormState extends State<AddressForm> {
  bool _hasTextInput = false;

  void _onTextChanged() {
    final has =
        widget.streetController.text.isNotEmpty &&
        widget.phoneController.text.isNotEmpty &&
        widget.usernameController.text.isNotEmpty;
    if (has != _hasTextInput) {
      setState(() => _hasTextInput = has);
    }
  }

  @override
  void initState() {
    super.initState();
    widget.streetController.addListener(_onTextChanged);
    widget.phoneController.addListener(_onTextChanged);
    widget.usernameController.addListener(_onTextChanged);
    _onTextChanged();
  }

  @override
  void dispose() {
    widget.streetController.removeListener(_onTextChanged);
    widget.phoneController.removeListener(_onTextChanged);
    widget.usernameController.removeListener(_onTextChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          BlocBuilder<AddressesCubit, AddressesStates>(
            buildWhen: (previous, current) =>
                previous.formSelectedLat != current.formSelectedLat ||
                previous.formSelectedLng != current.formSelectedLng,
            builder: (context, state) {
              return MapPreview(
                latLng: LatLng(state.formSelectedLat, state.formSelectedLng),

                onTap: widget.onPickLocation,
              );
            },
          ),
          const SizedBox(height: 24),
          AddressTextField(
            controller: widget.streetController,
            label: context.addressLabel,
            hint: context.enterAddress,
            errorText: context.enterAddress,
          ),
          const SizedBox(height: 16),
          PhoneField(controller: widget.phoneController),
          const SizedBox(height: 16),
          AddressTextField(
            controller: widget.usernameController,
            label: context.recipientName,
            hint: context.enterRecipientName,
            errorText: context.enterRecipientName,
          ),
          const SizedBox(height: 16),
          CityAreaRow(
            onCityChanged: widget.onCityChanged,
            onAreaChanged: widget.onAreaChanged,
          ),
          const SizedBox(height: 32),
          BlocBuilder<AddressesCubit, AddressesStates>(
            builder: (context, state) {
              final isLoading =
                  state.addAddressState.isLoading ||
                  state.updateAddressState.isLoading;
              final isEnabled =
                  _hasTextInput &&
                  state.formSelectedCity != null &&
                  state.formSelectedArea != null;

              return CustomButton(
                text: context.saveAddress,
                onPressed: isEnabled && !isLoading ? widget.onSubmit : null,
                isLoading: isLoading,
                isEnabled: isEnabled,
                backgroundColor: AppColors.primerColor,
                textColor: AppColors.white,
              );
            },
          ),
        ],
      ),
    );
  }
}
