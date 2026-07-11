import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/core/values/app_font_style.dart';
import 'package:flowers_app/core/values/app_strings.dart';
import 'package:flowers_app/core/widgets/custom_button.dart';
import 'package:flowers_app/features/checkout/domain/entities/checkout_address_entity.dart';
import 'package:flutter/material.dart';

class CheckoutAddressCard extends StatelessWidget {
  final List<CheckoutAddressEntity> addresses;
  final int selectedIndex;
  final ValueChanged<int> onChanged;
  final VoidCallback onShowAllAddresses;

  const CheckoutAddressCard({
    super.key,
    required this.addresses,
    required this.selectedIndex,
    required this.onChanged,
    required this.onShowAllAddresses,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: AppColors.whiteF9,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        spacing: 16,
        children: [
          Text(
            AppStrings.deliveryAddress,
            style: AppFontStyle.medium18(
              context: context,
            ).copyWith(color: AppColors.black0C),
          ),
          for (var i = 0; i < addresses.length; i++)
            _AddressCard(
              title: addresses[i].label,
              address: addresses[i].address,
              isSelected: selectedIndex == i,
              onTap: () => onChanged(i),
            ),
          SizedBox(
            width: double.infinity,
            height: 36,
            child: CustomButton(
              variant: ButtonVariant.outlined,
              onPressed: onShowAllAddresses,
              text: null,
              child: Row(
                spacing: 4,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppStrings.showAllAddresses,
                    style: AppFontStyle.medium14(
                      context: context,
                    ).copyWith(color: AppColors.primerColor),
                  ),
                  const Icon(
                    Icons.list,
                    size: 20,
                    color: AppColors.primerColor,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AddressCard extends StatelessWidget {
  final String title;
  final String address;
  final bool isSelected;
  final VoidCallback onTap;

  const _AddressCard({
    required this.title,
    required this.address,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.whiteF9,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: AppColors.gray53.withValues(alpha: 0.25),
              blurRadius: 4,
            ),
          ],
        ),
        child: Row(
          children: [
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
                        width: 12,
                        height: 12,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primerColor,
                        ),
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppFontStyle.medium16(
                      context: context,
                    ).copyWith(color: AppColors.black0C),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    address,
                    style: AppFontStyle.regular13(
                      context: context,
                    ).copyWith(color: AppColors.gray53),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            const Icon(Icons.edit, color: AppColors.gray53, size: 20),
          ],
        ),
      ),
    );
  }
}
