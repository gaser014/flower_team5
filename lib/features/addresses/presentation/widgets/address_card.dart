import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/core/values/app_font_style.dart';
import 'package:flowers_app/features/addresses/domain/entities/address_entity.dart';
import 'package:flutter/material.dart';

class AddressCard extends StatelessWidget {
  final AddressEntity address;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final bool isDeleting;

  const AddressCard({
    super.key,
    required this.address,
    this.onEdit,
    this.onDelete,
    this.isDeleting = false,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      color: AppColors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(color: AppColors.grayEA),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.location_on_outlined,
              color: AppColors.primerColor,
              size: 22,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (address.username != null && address.username!.isNotEmpty)
                    Text(
                      address.username!,
                      style: AppFontStyle.semiBold16(context: context),
                    ),
                  if (address.username != null && address.username!.isNotEmpty)
                    const SizedBox(height: 4),
                  if (address.city != null && address.city!.isNotEmpty)
                    Text(
                      address.city!,
                      style: AppFontStyle.medium14(context: context),
                    ),
                  if (address.city != null && address.city!.isNotEmpty)
                    const SizedBox(height: 4),
                  if (address.street != null && address.street!.isNotEmpty)
                    Text(
                      address.street!,
                      style: AppFontStyle.regular14(
                        context: context,
                      ).copyWith(color: AppColors.gray7D),
                    ),
                  if (address.phone != null && address.phone!.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(
                      address.phone!,
                      style: AppFontStyle.regular12(
                        context: context,
                      ).copyWith(color: AppColors.gray7D),
                    ),
                  ],
                ],
              ),
            ),
            if (isDeleting)
              const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppColors.redCC,
                ),
              )
            else ...[
              if (onDelete != null)
                IconButton(
                  padding: EdgeInsets.zero,
                  visualDensity: VisualDensity.compact,
                  icon: const Icon(
                    Icons.delete_outline,
                    color: AppColors.redCC,
                    size: 22,
                  ),
                  onPressed: onDelete,
                ),
              if (onEdit != null)
                IconButton(
                  padding: EdgeInsets.zero,
                  visualDensity: VisualDensity.compact,
                  icon: const Icon(
                    Icons.edit_outlined,
                    color: AppColors.black35,
                    size: 22,
                  ),
                  onPressed: onEdit,
                ),
            ],
          ],
        ),
      ),
    );
  }
}
