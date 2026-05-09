import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/values/app_assets.dart';
import '../../../../core/values/app_colors.dart';
import '../../../../core/values/app_font_style.dart';
import '../../domain/entities/product_entity.dart';

class ProductCard extends StatelessWidget {
  final ProductEntity product;
  final VoidCallback onAddToCart;

  const ProductCard({
    super.key,
    required this.product,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    int discountPercent = 0;
    if (product.price != null && product.priceAfterDiscount != null && product.price! > 0) {
      discountPercent = (((product.price! - product.priceAfterDiscount!) / product.price!) * 100).round();
    }

    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.grayEA),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.pinkF9,
                borderRadius: BorderRadius.vertical(top: Radius.circular(8.r)),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(8.r)),
                child: product.cover != null
                    ? Image.network(product.cover!, fit: BoxFit.cover)
                    : Center(
                        child: SvgPicture.asset(
                          AppAssets.iconsFlower,
                          width: 40.w,
                          colorFilter: const ColorFilter.mode(AppColors.primerColor, BlendMode.srcIn),
                        ),
                      ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title ?? 'Product Title',
                  style: AppFontStyle.regular12(context: context).copyWith(color: AppColors.black),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'EGP ${product.priceAfterDiscount ?? product.price ?? 0}',
                      style: AppFontStyle.bold12(context: context).copyWith(color: AppColors.black),
                    ),
                    SizedBox(width: 4.w),
                    if (product.priceAfterDiscount != null) ...[
                      Text(
                        '${product.price}',
                        style: AppFontStyle.regular10(context: context).copyWith(
                          color: AppColors.grayA6,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        '$discountPercent%',
                        style: AppFontStyle.regular10(context: context).copyWith(color: AppColors.green0C),
                      ),
                    ],
                  ],
                ),
                SizedBox(height: 8.h),
                SizedBox(
                  width: double.infinity,
                  height: 32.h,
                  child: ElevatedButton.icon(
                    onPressed: onAddToCart,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primerColor,
                      foregroundColor: AppColors.white,
                      elevation: 0,
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4.r)),
                    ),
                    icon: SvgPicture.asset(AppAssets.iconsCart, width: 14.w, colorFilter: const ColorFilter.mode(AppColors.white, BlendMode.srcIn)),
                    label: Text('Add to cart', style: AppFontStyle.medium12(context: context).copyWith(color: AppColors.white)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
