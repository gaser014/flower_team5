import 'package:flutter/material.dart';

import 'package:flowers_app/core/localization_constants/address_constants.dart';
import 'package:flowers_app/core/location_data/egypt_location_loader.dart';
import 'package:flowers_app/core/widgets/global/area_dropdown_field.dart';
import 'package:flowers_app/core/widgets/global/governorate_dropdown_field.dart';

class CityAreaRow extends StatelessWidget {
  final CityItem? selectedCity;
  final AreaItem? selectedArea;
  final ValueChanged<CityItem> onCityChanged;
  final ValueChanged<AreaItem?> onAreaChanged;

  const CityAreaRow({
    super.key,
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
