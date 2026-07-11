import 'package:flowers_app/core/theme/app_theme.dart';
import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/core/values/app_font_style.dart';
import 'package:flowers_app/core/values/app_strings.dart';
import 'package:flowers_app/core/widgets/custom_cached_image.dart';
import 'package:flowers_app/features/products/domain/entities/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class ProductItem extends StatelessWidget {
  final ProductEntity product;
  final VoidCallback onTap;

  const ProductItem({super.key, required this.product, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16.r),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: AppColors.shadowBox,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Hero(
                  tag: 'product-hero-${product.id}',
                  child: ClipRRect(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(16.r),
                    ),
                    child: CustomCachedImage(
                      imagePath: product.imgCover ?? '',
                      height: 180.h,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                if (product.discount != null && product.discount! > 0)
                  Positioned(
                    top: 8.h,
                    right: 8.w,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8.w,
                        vertical: 4.h,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.green0C.withValues(alpha: 0.9),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        '${product.discount}%',
                        style: AppFontStyle.medium12(
                          context: context,
                        ).copyWith(color: AppColors.white),
                      ),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(12.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title ?? '',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppFontStyle.medium16(context: context),
                  ),
                  Gap(4.h),
                  Row(
                    children: [
                      Text(
                        '${AppStrings.egp} ${(product.priceAfterDiscount ?? product.price ?? 0).toStringAsFixed(0)}',
                        style: AppFontStyle.semiBold16(
                          context: context,
                        ).copyWith(color: AppColors.primerColor),
                      ),
                      if (product.priceAfterDiscount != null &&
                          product.price != null) ...[
                        Gap(8.w),
                        Text(
                          product.price?.toStringAsFixed(0) ?? '',
                          style: AppFontStyle.regular12(context: context)
                              .copyWith(
                                color: AppColors.grayA6,
                                decoration: TextDecoration.lineThrough,
                              ),
                        ),
                      ],
                    ],
                  ),
                  Gap(12.h),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {}, // TODO: Add to cart
                      style: AppTheme.addToCartButtonStyle(context),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.shopping_cart_outlined, size: 16.sp),
                          Gap(4.w),
                          Text(
                            AppStrings.addToCart,
                            style: AppFontStyle.medium14(context: context),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
