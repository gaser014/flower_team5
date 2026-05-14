import 'package:flowers_app/core/values/app_assets.dart';
import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/core/values/app_font_style.dart';
import 'package:flowers_app/core/values/app_strings.dart';
import 'package:flowers_app/core/widgets/custom_cached_image.dart';
import 'package:flowers_app/features/products/domain/entities/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProductCard extends StatelessWidget {
  final ProductEntity product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
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
          _AddToCartButton(onTap: () {}),
        ],
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
        imagePath: imgCover!,
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
  const _AddToCartButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 6, horizontal: 24),
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
              color: AppColors.whiteF9,
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
