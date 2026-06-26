import 'package:flutter/material.dart';
import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/core/values/app_font_style.dart';
import 'package:flowers_app/core/values/app_strings.dart';
import 'package:gap/gap.dart';

class TrackOrderBottomBar extends StatelessWidget {
  const TrackOrderBottomBar({
    super.key,
    required this.onShowMap,
    this.onCall,
    this.onChat,
  });

  final VoidCallback onShowMap;
  final VoidCallback? onCall;
  final VoidCallback? onChat;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
      decoration: const BoxDecoration(
        color: AppColors.whiteF9,
        boxShadow: [BoxShadow(color: Color(0x33000000), blurRadius: 2)],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            _ContactIcon(icon: Icons.call_outlined, onTap: onCall),
            const Gap(16),
            _ContactIcon(icon: Icons.chat_bubble_outline, onTap: onChat),
            const Gap(16),
            Expanded(child: _ShowMapButton(onPressed: onShowMap)),
          ],
        ),
      ),
    );
  }
}

class _ContactIcon extends StatelessWidget {
  const _ContactIcon({required this.icon, this.onTap});

  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      customBorder: const CircleBorder(),
      child: Icon(icon, size: 24, color: AppColors.black0C),
    );
  }
}

class _ShowMapButton extends StatelessWidget {
  const _ShowMapButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primerColor,
          foregroundColor: AppColors.whiteF9,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        child: Text(
          AppStrings.showMap,
          style: AppFontStyle.medium16(
            context: context,
          ).copyWith(color: AppColors.whiteF9),
        ),
      ),
    );
  }
}
