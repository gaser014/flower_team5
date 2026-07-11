import 'package:flowers_app/core/localization_constants/order_tracking_constants.dart';
import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/core/values/app_font_style.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class DeliveryManRow extends StatelessWidget {
  const DeliveryManRow({
    super.key,
    required this.driverName,
    required this.driverPhoto,
    this.onCall,
    this.onChat,
  });

  final String driverName;
  final String driverPhoto;
  final VoidCallback? onCall;
  final VoidCallback? onChat;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildAvatar(),
        const Gap(16),
        Expanded(child: _buildInfo(context)),
        _buildActions(),
      ],
    );
  }

  Widget _buildAvatar() {
    final hasPhoto = driverPhoto.isNotEmpty;
    return CircleAvatar(
      radius: 18,
      backgroundColor: AppColors.pinkF9,
      backgroundImage: hasPhoto ? NetworkImage(driverPhoto) : null,
      child: hasPhoto
          ? null
          : const Icon(
              Icons.delivery_dining,
              size: 20,
              color: AppColors.primerColor,
            ),
    );
  }

  Widget _buildInfo(BuildContext context) {
    final name = driverName.isNotEmpty ? driverName : context.yourDriver;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppFontStyle.medium14(
            context: context,
          ).copyWith(color: AppColors.black0C),
        ),
        const Gap(4),
        Text(
          context.deliveryHero,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppFontStyle.medium12(
            context: context,
          ).copyWith(color: AppColors.gray53),
        ),
      ],
    );
  }

  Widget _buildActions() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _ActionIcon(icon: Icons.call, onTap: onCall),
        const Gap(16),
        _ActionIcon(icon: Icons.chat, onTap: onChat),
      ],
    );
  }
}

class _ActionIcon extends StatelessWidget {
  const _ActionIcon({required this.icon, this.onTap});

  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: Icon(icon, size: 24, color: AppColors.primerColor),
      ),
    );
  }
}
