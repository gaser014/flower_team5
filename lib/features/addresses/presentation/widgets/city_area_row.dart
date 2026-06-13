import 'package:flowers_app/core/values/app_strings.dart';
import 'package:flowers_app/features/addresses/presentation/cubit/addresses_cubit.dart';
import 'package:flutter/material.dart';

import 'package:flowers_app/core/location_data/egypt_location_loader.dart';
import 'package:flowers_app/core/widgets/global/area_dropdown_field.dart';
import 'package:flowers_app/core/widgets/global/governorate_dropdown_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CityAreaRow extends StatelessWidget {
  final ValueChanged<CityItem> onCityChanged;
  final ValueChanged<AreaItem?> onAreaChanged;

  const CityAreaRow({
    super.key,
    required this.onCityChanged,
    required this.onAreaChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BlocBuilder<AddressesCubit, AddressesStates>(
          buildWhen: (previous, current) =>
              previous.formSelectedCity != current.formSelectedCity,
          builder: (context, state) {
            return Expanded(
              child: GovernorateDropdownField(
                selectedGovernorate: state.formSelectedCity,
                onChanged: (city) {
                  if (city != null) onCityChanged(city);
                },
                labelText: AppStrings.cityLabel,
                validatorText: AppStrings.selectCity,
              ),
            );
          },
        ),
        const SizedBox(width: 12),
        Expanded(
          child: BlocBuilder<AddressesCubit, AddressesStates>(
            buildWhen: (previous, current) =>
                previous.formSelectedCity != current.formSelectedCity ||
                previous.formSelectedArea != current.formSelectedArea,
            builder: (context, state) {
              return AreaDropdownField(
                selectedGovernorateId: state.formSelectedCity?.id,
                selectedArea: state.formSelectedArea,
                onChanged: onAreaChanged,
                labelText: AppStrings.areaLabel,
                validatorText: AppStrings.selectArea,
              );
            },
          ),
        ),
      ],
    );
  }
}
