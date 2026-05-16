import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/core/values/app_font_style.dart';
import 'package:flowers_app/core/values/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SortByBottomSheet extends StatefulWidget {
  final String selectedSortBy;
  final Function(String) onSortSelected;

  const SortByBottomSheet({
    super.key,
    required this.selectedSortBy,
    required this.onSortSelected,
  });

  @override
  State<SortByBottomSheet> createState() => _SortByBottomSheetState();
}

class _SortByBottomSheetState extends State<SortByBottomSheet> {
  late String _currentSortBy;

  final List<Map<String, String>> _sortOptions = [
    {'label': AppStrings.lowestPrice, 'value': 'price'},
    {'label': AppStrings.highestPrice, 'value': '-price'},
    {'label': AppStrings.newArrival, 'value': '-createdAt'},
    {'label': AppStrings.old, 'value': 'createdAt'},
    {'label': AppStrings.discount, 'value': '-discount'},
  ];

  @override
  void initState() {
    super.initState();
    _currentSortBy = widget.selectedSortBy;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.grayEA,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const Gap(24),
          Text(
            AppStrings.sortBy,
            style: AppFontStyle.bold18(context: context).copyWith(
              color: AppColors.primerColor,
            ),
          ),
          const Gap(16),
          ..._sortOptions.map((option) => _buildSortOption(option)),
          const Gap(24),
          SizedBox(
            width: double.infinity,
            height: 48,
            child: ElevatedButton(
              onPressed: () {
                widget.onSortSelected(_currentSortBy);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primerColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                AppStrings.filter,
                style: AppFontStyle.bold16(context: context).copyWith(
                  color: AppColors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSortOption(Map<String, String> option) {
    final isSelected = _currentSortBy == option['value'];
    return InkWell(
      onTap: () {
        setState(() {
          _currentSortBy = option['value']!;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              option['label']!,
              style: AppFontStyle.medium14(context: context).copyWith(
                color: isSelected ? AppColors.black : AppColors.grayA6,
              ),
            ),
            Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? AppColors.primerColor : AppColors.grayEA,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Center(
                      child: Container(
                        height: 10,
                        width: 10,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primerColor,
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
