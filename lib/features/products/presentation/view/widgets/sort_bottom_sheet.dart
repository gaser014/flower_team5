import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/core/values/app_font_style.dart';
import 'package:flowers_app/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';

enum SortOption {
  lowestPrice('Lowes Price'),
  highestPrice('Highest Price'),
  newest('New'),
  oldest('Old'),
  discount('Discount');

  final String label;
  const SortOption(this.label);
}

class SortBottomSheet extends StatefulWidget {
  final SortOption initialOption;

  const SortBottomSheet({super.key, this.initialOption = SortOption.newest});

  @override
  State<SortBottomSheet> createState() => _SortBottomSheetState();
}

class _SortBottomSheetState extends State<SortBottomSheet> {
  late SortOption selectedOption;

  @override
  void initState() {
    super.initState();
    selectedOption = widget.initialOption;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 50,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.grayA6,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Sort by',
            style: AppFontStyle.semiBold20(context: context).copyWith(
              color: AppColors.primerColor,
            ),
          ),
          const SizedBox(height: 16),
          ...SortOption.values.map((option) => _SortOptionItem(
                option: option,
                isSelected: selectedOption == option,
                onSelect: (val) => setState(() => selectedOption = val),
              )),
          const SizedBox(height: 24),
          CustomButton(
            text: 'Filter',
            onPressed: () => Navigator.pop(context, selectedOption),
            backgroundColor: AppColors.primerColor,
          ),
        ],
      ),
    );
  }
}

class _SortOptionItem extends StatelessWidget {
  final SortOption option;
  final bool isSelected;
  final ValueChanged<SortOption> onSelect;

  const _SortOptionItem({
    required this.option,
    required this.isSelected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onSelect(option),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              option.label,
              style: AppFontStyle.medium16(context: context).copyWith(
                color: AppColors.black0C,
              ),
            ),
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? AppColors.primerColor : AppColors.grayA6,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          color: AppColors.primerColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                    )
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
