import 'package:flowers_app/config/base_state/base_state.dart';
import 'package:flowers_app/config/dependency_injection/di.dart';
import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/core/values/app_font_style.dart';
import 'package:flowers_app/core/values/app_strings.dart';
import 'package:flowers_app/core/widgets/custom_cached_image.dart';
import 'package:flowers_app/features/products/domain/entities/product_entity.dart';
import 'package:flowers_app/features/product_details/presentation/view_model/cubit/product_details_cubit.dart';
import 'package:flowers_app/features/product_details/presentation/view_model/cubit/product_details_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class ProductDetailsPage extends StatelessWidget {
  /// Pass a full entity when navigating from a list (e.g. Best Seller).
  /// Pass only the id when navigating from a deep link or notification.
  final ProductEntity? product;
  final String? productId;

  const ProductDetailsPage({super.key, this.product, this.productId})
    : assert(
        product != null || productId != null,
        'Either product or productId must be provided.',
      );

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = getIt<ProductDetailsCubit>();
        if (product != null) {
          cubit.onEvent(SetProductDetailsEvent(product: product!));
        } else {
          cubit.onEvent(GetProductDetailsEvent(id: productId!));
        }
        return cubit;
      },
      child: const _ProductDetailsView(),
    );
  }
}

class _ProductDetailsView extends StatelessWidget {
  const _ProductDetailsView();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductDetailsCubit, BaseState<ProductEntity>>(
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              if (state.isLoading)
                const Center(child: CircularProgressIndicator())
              else if (state.isError)
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.error_outline,
                        size: 48,
                        color: AppColors.redCC,
                      ),
                      Gap(16.h),
                      Text(
                        state.exception?.toString() ?? 'Something went wrong',
                        style: AppFontStyle.regular14(context: context),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                )
              else if (state.isSuccess && state.data != null)
                _ProductDetailsContent(product: state.data!)
              else
                const SizedBox.shrink(),
              // Back button — always visible
              Positioned(
                top: MediaQuery.of(context).padding.top + 8.h,
                left: 16.w,
                child: CircleAvatar(
                  backgroundColor: AppColors.white.withOpacity(0.5),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back, color: AppColors.black),
                    onPressed: () => context.pop(),
                  ),
                ),
              ),
              // Add to Cart button — only when content loaded
              if (state.isSuccess && state.data != null)
                Positioned(
                  bottom: 24.h,
                  left: 16.w,
                  right: 16.w,
                  child: SizedBox(
                    width: double.infinity,
                    height: 56.h,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primerColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                      ),
                      child: Text(
                        AppStrings.addToCart,
                        style: AppFontStyle.semiBold18(
                          context: context,
                        ).copyWith(color: AppColors.white),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

class _ProductDetailsContent extends StatelessWidget {
  final ProductEntity product;

  const _ProductDetailsContent({required this.product});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag: 'product_${product.id}',
            child: CustomCachedImage(
              imagePath: product.imgCover ?? '',
              width: double.infinity,
              height: 400.h,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'EGP ${product.priceAfterDiscount?.toStringAsFixed(0)}',
                      style: AppFontStyle.semiBold24(
                        context: context,
                      ).copyWith(color: AppColors.black),
                    ),
                    Text(
                      'Status: ${product.slug ?? AppStrings.inStock}',
                      style: AppFontStyle.medium14(
                        context: context,
                      ).copyWith(color: AppColors.black),
                    ),
                  ],
                ),
                Gap(4.h),
                Text(
                  'All prices include tax',
                  style: AppFontStyle.regular12(
                    context: context,
                  ).copyWith(color: AppColors.grayA6),
                ),
                Gap(16.h),
                Text(
                  product.title ?? '',
                  style: AppFontStyle.semiBold20(context: context),
                ),
                Gap(24.h),
                Text(
                  AppStrings.description,
                  style: AppFontStyle.semiBold18(context: context),
                ),
                Gap(8.h),
                Text(
                  product.description ??
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.',
                  style: AppFontStyle.regular14(
                    context: context,
                  ).copyWith(color: AppColors.gray53),
                ),
                Gap(24.h),
                // if (product.sold != null &&
                //     product.bouquetInclude!.isNotEmpty) ...[
                //   Text(
                //     AppStrings.bouquetInclude,
                //     style: AppFontStyle.semiBold18(context: context),
                //   ),
                //   Gap(8.h),
                //   ...product.bouquetInclude!.map(
                //     (item) => Padding(
                //       padding: EdgeInsets.only(bottom: 4.h),
                //       child: Row(
                //         children: [
                //           Container(
                //             width: 4.w,
                //             height: 4.h,
                //             decoration: const BoxDecoration(
                //               color: AppColors.primerColor,
                //               shape: BoxShape.circle,
                //             ),
                //           ),
                //           Gap(8.w),
                //           Text(
                //             item,
                //             style: AppFontStyle.regular14(context: context),
                //           ),
                //         ],
                //       ),
                //     ),
                //   ),
                // ],
                Gap(100.h), // Space for bottom button
              ],
            ),
          ),
        ],
      ),
    );
  }
}
