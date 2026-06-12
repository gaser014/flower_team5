import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:osm_location_picker/osm_location_picker.dart';

import 'package:flowers_app/core/localization_constants/address_constants.dart';
import 'package:flowers_app/core/location_data/egypt_location_loader.dart';
import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/core/widgets/custom_app_bar.dart';
import 'package:flowers_app/features/addresses/domain/entities/address_entity.dart';
import 'package:flowers_app/features/addresses/presentation/cubit/addresses_cubit.dart';
import 'package:flowers_app/features/addresses/presentation/widgets/address_form.dart';

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
        _selectedLatLng = LatLng(
          double.tryParse(lat) ?? 0,
          double.tryParse(lng) ?? 0,
        );
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
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          setState(() => _selectedLatLng = result.latLng);
        }
      });
    }
  }

  void _onSubmit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    if (_selectedCity == null || _selectedArea == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(context.selectCity)));
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
        body: AddressForm(
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
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(context.addressSaved)));
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
