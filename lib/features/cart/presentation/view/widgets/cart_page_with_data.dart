import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/core/values/app_font_style.dart';
import 'package:flowers_app/core/values/app_strings.dart';
import 'package:flowers_app/core/widgets/custom_button.dart';
import 'package:flowers_app/features/cart/domain/entities/cart_entity.dart';
import 'package:flowers_app/features/cart/presentation/view/widgets/cart_item.dart';
import 'package:flowers_app/features/cart/presentation/view/widgets/cart_upper_part.dart';
import 'package:flowers_app/features/cart/presentation/view_model/cubit/cart_cubit.dart';
import 'package:flowers_app/features/cart/presentation/view_model/cubit/cart_events.dart';
import 'package:flowers_app/features/cart/presentation/view_model/cubit/cart_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartPageWithData extends StatelessWidget {
  const CartPageWithData({super.key, required this.cartViewModel});

  final CartCubit cartViewModel;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartStates>(
      builder: (context, state) {
        final cart = state.state.data;
        final products = cart?.cartProducts ?? const <CartProductEntity>[];
        final subTotal = state.totalPrice;
        const deliveryFee = 10.0;
        final total = subTotal + (products.isEmpty ? 0 : deliveryFee);

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              CartUpperPart(itemsCount: products.length),
              const SizedBox(height: 8),
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemBuilder: (context, index) {
                    final product = products[index];
                    return CartItemWidget(
                      cartProduct: product,
                      onAddFunction: () => _onAdd(state, product),
                      onDecrementFunction: () => _onDecrement(state, product),
                      onRemoveFunction: () => _onRemove(state, product),
                    );
                  },
                  separatorBuilder: (_, _) => const SizedBox(height: 24),
                  itemCount: products.length,
                ),
              ),
              const SizedBox(height: 16),
              _PriceSummary(
                subTotal: subTotal,
                deliveryFee: products.isEmpty ? 0 : deliveryFee,
                total: total,
              ),
              const SizedBox(height: 24),
              CustomButton(
                text: AppStrings.checkout,
                radius: 100,
                onPressed: products.isEmpty ? null : () {},
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  void _onAdd(CartStates state, CartProductEntity product) {
    if (state.currentActedUponProductId.isNotEmpty) return;
    cartViewModel.doIntent(
      AddProductToCartEvent(productId: product.id, fromCartScreen: true),
    );
  }

  void _onDecrement(CartStates state, CartProductEntity product) {
    if (state.currentActedUponProductId.isNotEmpty) return;
    if (product.productQuantityInCart == 1) {
      cartViewModel.doIntent(RemoveProductFromCartEvent(productId: product.id));
    } else {
      cartViewModel.doIntent(
        UpdateProductInCartEvent(
          productId: product.id,
          quantity: product.productQuantityInCart,
        ),
      );
    }
  }

  void _onRemove(CartStates state, CartProductEntity product) {
    if (state.currentActedUponProductId.isNotEmpty) return;
    cartViewModel.doIntent(RemoveProductFromCartEvent(productId: product.id));
  }
}

class _PriceSummary extends StatelessWidget {
  const _PriceSummary({
    required this.subTotal,
    required this.deliveryFee,
    required this.total,
  });

  final double subTotal;
  final double deliveryFee;
  final double total;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _PriceRow(
          label: 'Sub Total',
          value: '\$${subTotal.toStringAsFixed(0)}',
        ),
        const SizedBox(height: 8),
        _PriceRow(
          label: AppStrings.deliveryFee,
          value: '\$${deliveryFee.toStringAsFixed(0)}',
        ),
        const SizedBox(height: 16),
        const Divider(color: AppColors.grayCF, thickness: 0.5, height: 1),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              AppStrings.totalPrice,
              style: AppFontStyle.medium18(
                context: context,
              ).copyWith(color: AppColors.black0C),
            ),
            Text(
              '\$${total.toStringAsFixed(0)}',
              style: AppFontStyle.medium18(
                context: context,
              ).copyWith(color: AppColors.black0C),
            ),
          ],
        ),
      ],
    );
  }
}

class _PriceRow extends StatelessWidget {
  const _PriceRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppFontStyle.regular16(
            context: context,
          ).copyWith(color: AppColors.gray53),
        ),
        Text(
          value,
          style: AppFontStyle.regular16(
            context: context,
          ).copyWith(color: AppColors.gray53),
        ),
      ],
    );
  }
}
