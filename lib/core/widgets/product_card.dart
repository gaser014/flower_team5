import 'package:flowers_app/core/routes/routes.dart';
import 'package:flowers_app/core/values/app_assets.dart';
import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/core/values/app_font_style.dart';
import 'package:flowers_app/core/values/app_strings.dart';
import 'package:flowers_app/core/widgets/custom_cached_image.dart';
import 'package:flowers_app/features/cart/presentation/view_model/cubit/cart_cubit.dart';
import 'package:flowers_app/features/cart/presentation/view_model/cubit/cart_events.dart';
import 'package:flowers_app/features/cart/presentation/view_model/cubit/cart_states.dart';
import 'package:flowers_app/features/products/domain/entities/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class ProductCard extends StatelessWidget {
  final ProductEntity product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(Routes.productDetails, extra: product);
      },
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.gray53, width: .5),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _ProductImage(imgCover: product.imgCover),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    product.title ?? 'Product',
                    style: AppFontStyle.regular12(
                      context: context,
                    ).copyWith(color: AppColors.black0C),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  FittedBox(child: _PriceRow(product: product)),
                ],
              ),
            ),
            _AddToCartButton(product: product),
          ],
        ),
      ),
    );
  }
}

class _ProductImage extends StatelessWidget {
  const _ProductImage({required this.imgCover});

  final String? imgCover;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 148 / 132,
      child: CustomCachedImage(
        imagePath: imgCover ?? '',
        fit: BoxFit.cover,
        height: 132,
        width: 148,
      ),
    );
  }
}

class _PriceRow extends StatelessWidget {
  const _PriceRow({required this.product});

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    final hasDiscount =
        product.priceAfterDiscount != null &&
        product.price != null &&
        product.priceAfterDiscount! < product.price!;

    final displayPrice = hasDiscount
        ? product.priceAfterDiscount
        : product.price;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 4,
      children: [
        if (displayPrice != null)
          Text(
            'EGP $displayPrice',
            style: AppFontStyle.medium14(
              context: context,
            ).copyWith(color: AppColors.black0C),
          ),
        if (hasDiscount) ...[
          Text(
            product.price!.toString(),
            style: AppFontStyle.regular12(context: context).copyWith(
              color: AppColors.grayA6,
              decoration: TextDecoration.lineThrough,
              decorationColor: AppColors.gray53,
            ),
          ),
          Text(
            '${product.discount}%',
            style: AppFontStyle.regular12(
              context: context,
            ).copyWith(color: AppColors.green0C),
          ),
        ],
      ],
    );
  }
}

class _AddToCartButton extends StatelessWidget {
  const _AddToCartButton({required this.product});

  final ProductEntity product;

  @override
  Widget build(BuildContext context) {
    final productId = product.id;
    if (productId == null || productId.isEmpty) {
      return _AddButton(onTap: () {});
    }

    return BlocSelector<CartCubit, CartStates, int>(
      selector: (state) => state.quantityOf(productId),
      builder: (context, quantity) {
        final cubit = context.read<CartCubit>();
        if (quantity <= 0) {
          return _AddButton(
            onTap: () => cubit.doIntent(IncrementProductEvent(product)),
          );
        }
        return _QuantityStepper(
          quantity: quantity,
          onIncrement: () => cubit.doIntent(IncrementProductEvent(product)),
          onDecrement: () => cubit.doIntent(DecrementProductEvent(productId)),
        );
      },
    );
  }
}

class _AddButton extends StatelessWidget {
  const _AddButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 24),
        decoration: BoxDecoration(
          color: AppColors.primerColor,
          borderRadius: BorderRadius.circular(100),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 8,
          children: [
            SvgPicture.asset(
              AppAssets.iconsCart,
              width: 18,
              height: 18,
              colorFilter: const ColorFilter.mode(
                AppColors.whiteF9,
                BlendMode.srcIn,
              ),
            ),
            Text(
              AppStrings.addToCart,
              style: AppFontStyle.medium13(
                context: context,
              ).copyWith(color: AppColors.whiteF9),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuantityStepper extends StatelessWidget {
  const _QuantityStepper({
    required this.quantity,
    required this.onIncrement,
    required this.onDecrement,
  });

  final int quantity;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),

      decoration: BoxDecoration(
        color: AppColors.primerColor,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        spacing: 12,
        children: [
          Expanded(
            child: _StepperIcon(icon: Icons.remove_rounded, onTap: onDecrement),
          ),
          Text(
            '$quantity',
            style: AppFontStyle.semiBold14(
              context: context,
            ).copyWith(color: AppColors.whiteF9),
          ),
          Expanded(
            child: _StepperIcon(icon: Icons.add_rounded, onTap: onIncrement),
          ),
        ],
      ),
    );
  }
}

class _StepperIcon extends StatelessWidget {
  const _StepperIcon({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Icon(icon, size: 18, color: AppColors.whiteF9),
    );
  }
}
