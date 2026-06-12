import 'package:flowers_app/core/values/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/core/values/app_font_style.dart';
import 'package:flowers_app/features/addresses/domain/entities/address_entity.dart';

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
    return Container(
      decoration: BoxDecoration(
        color: AppColors.whiteF9,
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(83, 83, 83, 0.25),
            blurRadius: 2,
            offset: Offset.zero,
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  spacing: 4,
                  children: [
                    SvgPicture.asset(
                      AppAssets.locationMarkerSvg,
                      height: 20,
                      width: 20,
                      fit: BoxFit.scaleDown,
                      colorFilter: const ColorFilter.mode(
                        AppColors.black0C,
                        BlendMode.srcIn,
                      ),
                    ),

                    if (address.city != null && address.city!.isNotEmpty)
                      Text(
                        address.city!,
                        style: AppFontStyle.medium16(context: context),
                      ),
                  ],
                ),
                const SizedBox(height: 16),
                if (address.street != null && address.street!.isNotEmpty)
                  Text(
                    address.street!,
                    style: AppFontStyle.regular13(
                      context: context,
                    ).copyWith(color: AppColors.gray53),
                  ),
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
          else
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (onDelete != null)
                  _ActionIcon(
                    asset: AppAssets.deleteTrash,
                    onPressed: onDelete!,
                  ),
                const SizedBox(width: 4),
                if (onEdit != null)
                  _ActionIcon(asset: AppAssets.edit, onPressed: onEdit!),
              ],
            ),
        ],
      ),
    );
  }
}

class _ActionIcon extends StatelessWidget {
  final String asset;
  final VoidCallback onPressed;

  const _ActionIcon({required this.asset, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      onTapDown: (_) {},
      child: SvgPicture.asset(
        asset,
        height: 24,
        width: 24,
        fit: BoxFit.scaleDown,
      ),
    );
  }
}
