import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:osm_location_picker/osm_location_picker.dart';

import 'package:flowers_app/core/localization_constants/address_constants.dart';
import 'package:flowers_app/core/location_data/egypt_location_loader.dart';
import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/core/widgets/custom_app_bar.dart';
import 'package:flowers_app/core/widgets/global/area_dropdown_field.dart';
import 'package:flowers_app/core/widgets/global/governorate_dropdown_field.dart';
import 'package:flowers_app/features/addresses/domain/entities/address_entity.dart';
import 'package:flowers_app/features/addresses/presentation/cubit/addresses_cubit.dart';

class AddAddressScreen extends StatefulWidget {
  final AddressEntity? editAddress;

  const AddAddressScreen({super.key, this.editAddress});

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

class _AddAddressScreenState extends State<AddAddressScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _streetController;
  late final TextEditingController _phoneController;
  late final TextEditingController _usernameController;

  CityItem? _selectedCity;
  AreaItem? _selectedArea;
  LatLng? _selectedLatLng;

  bool get _isEditing => widget.editAddress != null;

  @override
  void initState() {
    super.initState();
    final edit = widget.editAddress;
    _streetController = TextEditingController(text: edit?.street ?? '');
    _phoneController = TextEditingController(text: edit?.phone ?? '');
    _usernameController = TextEditingController(text: edit?.username ?? '');

    if (edit != null) {
      final lat = edit.lat;
      final lng = edit.long;
      if (lat != null && lng != null) {
        _selectedLatLng = LatLng(double.tryParse(lat) ?? 0, double.tryParse(lng) ?? 0);
      }
    }

    _loadLocationData();
  }

  Future<void> _loadLocationData() async {
    if (_isEditing && widget.editAddress!.city != null) {
      final cities = await EgyptLocationLoader.loadCities();
      final matchedCity = cities.firstWhere(
        (c) =>
            c.nameEn.toLowerCase() == widget.editAddress!.city!.toLowerCase() ||
            c.nameAr == widget.editAddress!.city,
        orElse: () => const CityItem(id: '', nameEn: '', nameAr: ''),
      );

      if (matchedCity.id.isNotEmpty) {
        setState(() => _selectedCity = matchedCity);
      }
    }
  }

  void _onCitySelected(CityItem city) {
    setState(() {
      _selectedCity = city;
      _selectedArea = null;
    });
  }

  Future<void> _pickLocation() async {
    final result = await Navigator.of(context).push<LocationModel>(
      MaterialPageRoute(
        builder: (_) => LocationPickerView(
          initialLatLng: _selectedLatLng,
          theme: LocationPickerTheme(
            primaryColor: AppColors.primerColor,
            backgroundColor: AppColors.white,
          ),
        ),
      ),
    );

    if (result != null && mounted) {
      setState(() {
        _selectedLatLng = result.latLng;
      });
    }
  }

  void _onSubmit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    if (_selectedCity == null || _selectedArea == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.selectCity)),
      );
      return;
    }

    final entity = AddressEntity(
      id: widget.editAddress?.id,
      street: _streetController.text.trim(),
      phone: _phoneController.text.trim(),
      city: _selectedCity!.nameEn,
      lat: _selectedLatLng?.latitude.toString(),
      long: _selectedLatLng?.longitude.toString(),
      username: _usernameController.text.trim(),
    );

    if (_isEditing) {
      context.read<AddressesCubit>().doIntent(
        UpdateAddressEvent(entity: entity),
      );
    } else {
      context.read<AddressesCubit>().doIntent(AddAddressEvent(entity: entity));
    }
  }

  @override
  void dispose() {
    _streetController.dispose();
    _phoneController.dispose();
    _usernameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AddressesCubit, AddressesStates>(
      listenWhen: (prev, curr) =>
          prev.addAddressState != curr.addAddressState ||
          prev.updateAddressState != curr.updateAddressState,
      listener: _onAddressStateChanged,
      child: Scaffold(
        appBar: CustomAppBar(title: context.addressTitle),
        body: _AddressForm(
          formKey: _formKey,
          latLng: _selectedLatLng,
          selectedCity: _selectedCity,
          selectedArea: _selectedArea,
          streetController: _streetController,
          phoneController: _phoneController,
          usernameController: _usernameController,
          onCityChanged: _onCitySelected,
          onAreaChanged: (area) => setState(() => _selectedArea = area),
          onPickLocation: _pickLocation,
          onSubmit: _onSubmit,
        ),
      ),
    );
  }

  void _onAddressStateChanged(BuildContext context, AddressesStates state) {
    final addState = state.addAddressState;
    final updateState = state.updateAddressState;

    if (addState.isSuccess || updateState.isSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(context.addressSaved)),
      );
      Navigator.pop(context, true);
    } else if (addState.isError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(addState.exception?.toString() ?? 'Error')),
      );
    } else if (updateState.isError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(updateState.exception?.toString() ?? 'Error')),
      );
    }
  }
}

class _AddressForm extends StatelessWidget {
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

  const _AddressForm({
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
        children: _buildFormFields(context),
      ),
    );
  }

  List<Widget> _buildFormFields(BuildContext context) => [
    _MapPreview(latLng: latLng, onTap: onPickLocation),
    const SizedBox(height: 24),
    _AddressTextField(
      controller: streetController,
      label: context.addressLabel,
      hint: context.enterAddress,
      errorText: context.enterAddress,
    ),
    const SizedBox(height: 16),
    _AddressTextField(
      controller: phoneController,
      label: context.phoneNumber,
      hint: context.enterPhoneNumber,
      errorText: context.enterPhoneNumber,
      keyboardType: TextInputType.phone,
    ),
    const SizedBox(height: 16),
    _AddressTextField(
      controller: usernameController,
      label: context.recipientName,
      hint: context.enterRecipientName,
      errorText: context.enterRecipientName,
    ),
    const SizedBox(height: 16),
    _CityAreaRow(
      selectedCity: selectedCity,
      selectedArea: selectedArea,
      onCityChanged: onCityChanged,
      onAreaChanged: onAreaChanged,
    ),
    const SizedBox(height: 32),
    _SubmitButton(onSubmit: onSubmit),
  ];
}

class _MapPreview extends StatelessWidget {
  final LatLng? latLng;
  final VoidCallback onTap;

  const _MapPreview({required this.latLng, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 180,
        decoration: BoxDecoration(
          color: AppColors.lightGray,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.grayEA),
        ),
        clipBehavior: Clip.antiAlias,
        child: latLng != null
            ? Stack(
                children: [
                  FlutterMap(
                    options: MapOptions(
                      center: latLng,
                      zoom: 15,
                      interactionOptions: const InteractionOptions(flags: InteractiveFlag.none),
                    ),
                    children: [
                      TileLayer(
                        urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                        userAgentPackageName: 'com.flowers_app',
                      ),
                      MarkerLayer(
                        markers: [
                          Marker(
                            point: latLng!,
                            child: const Icon(Icons.location_on, color: AppColors.primerColor, size: 36),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Positioned(
                    bottom: 8,
                    left: 8,
                    right: 8,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.white.withValues(alpha: 0.9),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        '${latLng!.latitude.toStringAsFixed(4)}, ${latLng!.longitude.toStringAsFixed(4)}',
                        style: const TextStyle(fontSize: 11, color: AppColors.black35),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.location_on, size: 48, color: AppColors.primerColor),
                    const SizedBox(height: 8),
                    Text(
                      'Tap to select location',
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).disabledColor,
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

class _AddressTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final String errorText;
  final TextInputType? keyboardType;

  const _AddressTextField({
    required this.controller,
    required this.label,
    required this.hint,
    required this.errorText,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
      keyboardType: keyboardType,
      validator: (v) => (v == null || v.trim().isEmpty) ? errorText : null,
    );
  }
}

class _CityAreaRow extends StatelessWidget {
  final CityItem? selectedCity;
  final AreaItem? selectedArea;
  final ValueChanged<CityItem> onCityChanged;
  final ValueChanged<AreaItem?> onAreaChanged;

  const _CityAreaRow({
    required this.selectedCity,
    required this.selectedArea,
    required this.onCityChanged,
    required this.onAreaChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: GovernorateDropdownField(
            selectedGovernorate: selectedCity,
            onChanged: (city) {
              if (city != null) onCityChanged(city);
            },
            labelText: context.cityLabel,
            validatorText: context.selectCity,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: AreaDropdownField(
            selectedGovernorateId: selectedCity?.id,
            selectedArea: selectedArea,
            onChanged: onAreaChanged,
            labelText: context.areaLabel,
            validatorText: context.selectArea,
          ),
        ),
      ],
    );
  }
}

class _SubmitButton extends StatelessWidget {
  final VoidCallback onSubmit;

  const _SubmitButton({required this.onSubmit});

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
