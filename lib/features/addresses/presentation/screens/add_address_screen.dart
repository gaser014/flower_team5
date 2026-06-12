import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:osm_location_picker/osm_location_picker.dart';

import 'package:flowers_app/config/helper/extensions/base_state/show_error_massage.dart';
import 'package:flowers_app/config/helper/extensions/base_state/show_success_massage.dart';
import 'package:flowers_app/core/helper/address_parser.dart';
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

  bool get _isEditing => widget.editAddress != null;

  @override
  void initState() {
    super.initState();
    final edit = widget.editAddress;
    _streetController = TextEditingController(text: edit?.street ?? '');
    _phoneController = TextEditingController(text: edit?.phone ?? '');
    _usernameController = TextEditingController(text: edit?.username ?? '');

    if (edit != null) {
      _loadLocationDataForEdit(edit);
    } else {
      context.read<AddressesCubit>().doIntent(ResetFormEvent());
    }
  }

  Future<void> _loadLocationDataForEdit(AddressEntity edit) async {
    if (edit.city == null) return;

    final cities = await EgyptLocationLoader.loadCities();
    final matchedCity = cities.firstWhere(
      (c) =>
          c.nameEn.toLowerCase() == edit.city!.toLowerCase() ||
          c.nameAr == edit.city!,
      orElse: () => const CityItem(id: '', nameEn: '', nameAr: ''),
    );

    final double? lat = edit.lat != null ? double.tryParse(edit.lat!) : null;
    final double? lng = edit.long != null ? double.tryParse(edit.long!) : null;

    if (matchedCity.id.isNotEmpty || lat != null || lng != null) {
      if (!mounted) return;
      context.read<AddressesCubit>().doIntent(
        UpdateFormLocationEvent(
          lat: lat,
          lng: lng,
          city: matchedCity.id.isNotEmpty ? matchedCity : null,
        ),
      );
    }
  }

  void _onCitySelected(CityItem city) {
    context.read<AddressesCubit>().doIntent(UpdateFormCityEvent(city: city));
  }

  Future<void> _pickLocation() async {
    final state = context.read<AddressesCubit>().state;
    final initialLatLng = LatLng(state.formSelectedLat, state.formSelectedLng);

    final result = await Navigator.of(context).push<LocationModel>(
      MaterialPageRoute(
        builder: (_) => LocationPickerView(
          initialLatLng: initialLatLng,
          theme: LocationPickerTheme(
            primaryColor: AppColors.primerColor,
            backgroundColor: AppColors.white,
          ),
        ),
      ),
    );

    if (result != null && result.latLng != null && mounted) {
      final addressString = result.address ?? '';
      final parsed = parseAddressString(addressString);

      CityItem? matchedCity;
      AreaItem? matchedArea;

      if (parsed != null) {
        final matched = await matchAddressFromParsed(parsed);
        matchedCity = matched?.city;
        matchedArea = matched?.area;

        if (parsed.street.isNotEmpty) {
          _streetController.text = parsed.street;
        }
      }

      if (mounted) {
        context.read<AddressesCubit>().doIntent(
          UpdateFormLocationEvent(
            lat: result.latLng!.latitude,
            lng: result.latLng!.longitude,
            city: matchedCity,
            area: matchedArea,
          ),
        );
      }
    }
  }

  void _onSubmit() {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    final cubit = context.read<AddressesCubit>();
    final s = cubit.state;
    if (s.formSelectedCity == null || s.formSelectedArea == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(context.selectCity)));
      return;
    }

    final entity = AddressEntity(
      id: widget.editAddress?.id,
      street: _streetController.text.trim(),
      phone: _phoneController.text.trim(),
      city: s.formSelectedCity!.nameEn,
      lat: s.formSelectedLat.toString(),
      long: s.formSelectedLng.toString(),
      username: _usernameController.text.trim(),
    );

    if (_isEditing) {
      cubit.doIntent(UpdateAddressEvent(entity: entity));
    } else {
      cubit.doIntent(AddAddressEvent(entity: entity));
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

          streetController: _streetController,
          phoneController: _phoneController,
          usernameController: _usernameController,
          onCityChanged: _onCitySelected,
          onAreaChanged: (area) => context.read<AddressesCubit>().doIntent(
            UpdateFormAreaEvent(area: area),
          ),
          onPickLocation: _pickLocation,
          onSubmit: _onSubmit,
        ),
      ),
    );
  }

  void _onAddressStateChanged(BuildContext context, AddressesStates state) {
    final addState = state.addAddressState;
    final updateState = state.updateAddressState;

    if (addState.isSuccess) {
      context.showSuccessMessage(
        state: addState,
        massage: context.addressSaved,
        onSuccess: () => context.pop(true),
      );
    } else if (updateState.isSuccess) {
      context.showSuccessMessage(
        state: updateState,
        massage: context.addressSaved,
        onSuccess: () => context.pop(true),
      );
    } else if (addState.isError) {
      context.showErrorMessage(addState);
    } else if (updateState.isError) {
      context.showErrorMessage(updateState);
    }
  }
}
