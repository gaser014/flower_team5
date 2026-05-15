import 'package:flowers_app/config/base_state/pagination_state.dart';
import 'package:flowers_app/core/routes/routes.dart';
import 'package:flowers_app/core/widgets/pagination_grid_view.dart';
import 'package:flowers_app/core/widgets/pagination_state_builder.dart';
import 'package:flowers_app/features/products/domain/entities/product_entity.dart';
import 'package:flowers_app/features/best_seller/presentation/view_model/cubit/best_seller_cubit.dart';
import 'package:flowers_app/features/best_seller/presentation/view_model/cubit/best_seller_events.dart';
import 'package:flowers_app/core/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class BestSellerBody extends StatelessWidget {
  const BestSellerBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Gap(24.h),
        Expanded(
          child: BlocBuilder<BestSellerCubit, PaginationState<ProductEntity>>(
            builder: (context, state) {
              return PaginationStateBuilder<ProductEntity>(
                state: state,
                onSuccess: (context, products) {
                  return PaginationGridView<ProductEntity>(
                    items: products,
                    padding: EdgeInsets.symmetric(horizontal: 16.w),

                    itemBuilder: (context, product, index) {
                      return ProductCard(product: product);
                    },
                    onLoadMore: () => context.read<BestSellerCubit>().onEvent(
                      GetBestSellersEvent(),
                    ),
                    onRefresh: () => context.read<BestSellerCubit>().onEvent(
                      GetBestSellersEvent(isRefresh: true),
                    ),
                    isLoading: state.isLoading,
                    isLoadingMore: state.isLoadingMore,
                    hasMore: state.hasMore,
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
