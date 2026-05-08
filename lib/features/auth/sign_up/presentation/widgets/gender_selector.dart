import 'package:flowers_app/config/helper/enum/gender.dart';
import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/core/values/app_font_style.dart';
import 'package:flowers_app/core/values/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/sign_up_cubit.dart';
import '../cubit/sign_up_state.dart';

class GenderSelector extends StatelessWidget {
  const GenderSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.gender != current.gender,
      builder: (context, state) {
        final cubit = context.read<SignUpCubit>();
        return Row(
          children: [
            Text(
              AppStrings.genderLabel,
              style: AppFontStyle.semiBold16(context: context).copyWith(
                color: AppColors.black0C,
              ),
            ),
            const SizedBox(width: 24),
            _GenderRadio(
              label: AppStrings.femaleLabel,
              value: Gender.female,
              groupValue: state.gender,
              onChanged: (value) => cubit.changeGender(value!),
            ),
            const SizedBox(width: 16),
            _GenderRadio(
              label: AppStrings.maleLabel,
              value: Gender.male,
              groupValue: state.gender,
              onChanged: (value) => cubit.changeGender(value!),
            ),
          ],
        );
      },
    );
  }
}

class _GenderRadio extends StatelessWidget {
  final String label;
  final Gender value;
  final Gender groupValue;
  final ValueChanged<Gender?> onChanged;

  const _GenderRadio({
    required this.label,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio<Gender>(
          value: value,
          groupValue: groupValue,
          onChanged: onChanged,
          activeColor: AppColors.primerColor,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          visualDensity: VisualDensity.compact,
        ),
        GestureDetector(
          onTap: () => onChanged(value),
          child: Text(
            label,
            style: AppFontStyle.regular14(context: context).copyWith(
              color: AppColors.black0C,
            ),
          ),
        ),
      ],
    );
  }
}
