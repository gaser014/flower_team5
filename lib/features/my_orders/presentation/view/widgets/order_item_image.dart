import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/core/widgets/custom_cached_image.dart';
import 'package:flutter/material.dart';

class OrderItemImage extends StatelessWidget {
  final String imageUrl;

  const OrderItemImage({super.key, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 127,
      height: 109,
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(
        color: AppColors.pinkF9,
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Center(
        child: CustomCachedImage(
          imagePath: imageUrl,
          fit: BoxFit.contain,
          errorWidget: Icon(Icons.image, color: AppColors.pinkF0, size: 36),
        ),
      ),
    );
  }
}
