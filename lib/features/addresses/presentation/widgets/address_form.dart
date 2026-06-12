import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

import 'package:flowers_app/core/localization_constants/address_constants.dart';
import 'package:flowers_app/core/location_data/egypt_location_loader.dart';
import 'package:flowers_app/core/widgets/text_field/phone_field.dart';
import 'package:flowers_app/features/addresses/presentation/widgets/address_text_field.dart';
import 'package:flowers_app/features/addresses/presentation/widgets/city_area_row.dart';
import 'package:flowers_app/features/addresses/presentation/widgets/map_preview.dart';
import 'package:flowers_app/features/addresses/presentation/widgets/submit_button.dart';

class AddressForm extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final LatLng? latLng;
  final CityItem? selectedCity;
  final AreaItem? selectedArea;
  final TextEditingController streetController;
  final TextEditingController phoneController;
  final TextEditingController usernameController;
  final ValueChanged<CityItem> onCityChanged;
  final ValueChanged<AreaItem?> onAreaChanged;
  final VoidCallback onPickLocation;
  final VoidCallback onSubmit;

  const AddressForm({
    super.key,
    required this.formKey,
    required this.latLng,
    required this.selectedCity,
    required this.selectedArea,
    required this.streetController,
    required this.phoneController,
    required this.usernameController,
    required this.onCityChanged,
    required this.onAreaChanged,
    required this.onPickLocation,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          MapPreview(latLng: latLng, onTap: onPickLocation),
          const SizedBox(height: 24),
          AddressTextField(
            controller: streetController,
            label: context.addressLabel,
            hint: context.enterAddress,
            errorText: context.enterAddress,
          ),
          const SizedBox(height: 16),
          PhoneField(controller: phoneController),
          const SizedBox(height: 16),
          AddressTextField(
            controller: usernameController,
            label: context.recipientName,
            hint: context.enterRecipientName,
            errorText: context.enterRecipientName,
          ),
          const SizedBox(height: 16),
          CityAreaRow(
            selectedCity: selectedCity,
            selectedArea: selectedArea,
            onCityChanged: onCityChanged,
            onAreaChanged: onAreaChanged,
          ),
          const SizedBox(height: 32),
          SubmitButton(onSubmit: onSubmit),
        ],
      ),
    );
  }
}
