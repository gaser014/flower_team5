import 'package:flowers_app/core/values/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';
import 'package:osm_location_picker/osm_location_picker.dart';

import 'package:flowers_app/config/helper/extensions/base_state/show_error_massage.dart';
import 'package:flowers_app/config/helper/extensions/base_state/show_success_massage.dart';
import 'package:flowers_app/core/helper/address_parser.dart';
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

    context.read<AddressesCubit>().doIntent(InitFormEvent(editAddress: edit));
  }

  void _onCitySelected(GovernorateItem city) {
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

      GovernorateItem? matchedCity;
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
      ).showSnackBar(SnackBar(content: Text(AppStrings.selectCity)));
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
        appBar: CustomAppBar(title: AppStrings.addressTitle),
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
    final opState = _isEditing
        ? state.updateAddressState
        : state.addAddressState;

    if (opState.isSuccess) {
      context.showSuccessMessage(
        state: opState,
        massage: AppStrings.addressSaved,
        onSuccess: () => context.pop(true),
      );
    } else if (opState.isError) {
      context.showErrorMessage(opState);
    }
  }
}
