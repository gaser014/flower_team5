import 'package:flowers_app/core/values/app_assets.dart';
import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/core/values/app_font_style.dart';
import 'package:flowers_app/core/values/app_strings.dart';
import 'package:flowers_app/core/widgets/custom_cached_image.dart';
import 'package:flowers_app/features/cart/domain/entities/cart_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CartItemWidget extends StatelessWidget {
  final CartProductEntity cartProduct;
  final VoidCallback onAddFunction;
  final VoidCallback onRemoveFunction;
  final VoidCallback onDecrementFunction;

  const CartItemWidget({
    super.key,
    required this.cartProduct,
    required this.onAddFunction,
    required this.onRemoveFunction,
    required this.onDecrementFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.whiteF9,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.gray53, width: 0.5),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _ProductImage(imageUrl: cartProduct.productImage),
          const SizedBox(width: 8),
          Expanded(
            child: SizedBox(
              height: 84,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _ProductHeader(
                    name: cartProduct.productName,
                    description: cartProduct.productDescription,
                    onRemove: onRemoveFunction,
                  ),
                  _PriceAndQuantity(
                    price: cartProduct.productPrice,
                    quantity: cartProduct.productQuantityInCart,
                    onIncrement: onAddFunction,
                    onDecrement: onDecrementFunction,
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

class _ProductImage extends StatelessWidget {
  const _ProductImage({required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 96,
      height: 101,
      decoration: BoxDecoration(
        color: AppColors.pinkF9,
        borderRadius: BorderRadius.circular(8),
      ),
      clipBehavior: Clip.antiAlias,
      alignment: Alignment.center,
      child: imageUrl.isNotEmpty
          ? CustomCachedImage(
              imagePath: imageUrl,
              fit: BoxFit.contain,
              width: 66,
              height: 87,
            )
          : SvgPicture.asset(AppAssets.iconsFlower, width: 66, height: 87),
    );
  }
}

class _ProductHeader extends StatelessWidget {
  const _ProductHeader({
    required this.name,
    required this.description,
    required this.onRemove,
  });

  final String name;
  final String description;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                name,
                style: AppFontStyle.medium16(
                  context: context,
                ).copyWith(color: AppColors.black0C),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: AppFontStyle.regular13(
                  context: context,
                ).copyWith(color: AppColors.gray53),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: onRemove,
          behavior: HitTestBehavior.opaque,
          child: SvgPicture.asset(AppAssets.iconsDelete, width: 24, height: 24),
        ),
      ],
    );
  }
}

class _PriceAndQuantity extends StatelessWidget {
  const _PriceAndQuantity({
    required this.price,
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
  });

  final double price;
  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Text(
            '${AppStrings.egp} ${price.toStringAsFixed(0)}',
            style: AppFontStyle.semiBold14(
              context: context,
            ).copyWith(color: AppColors.black0C),
          ),
        ),
        _QuantityControls(
          quantity: quantity,
          onIncrement: onIncrement,
          onDecrement: onDecrement,
        ),
      ],
    );
  }
}

class _QuantityControls extends StatelessWidget {
  const _QuantityControls({
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
  });

  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _QuantityButton(icon: Icons.remove_rounded, onTap: onDecrement),
        const SizedBox(width: 8),
        Text(
          '$quantity',
          style: AppFontStyle.semiBold14(
            context: context,
          ).copyWith(color: AppColors.black0C),
        ),
        const SizedBox(width: 8),
        _QuantityButton(icon: Icons.add_rounded, onTap: onIncrement),
      ],
    );
  }
}

class _QuantityButton extends StatelessWidget {
  const _QuantityButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 24,
        height: 24,
        child: Icon(icon, size: 18, color: AppColors.black0C),
      ),
    );
  }
}
