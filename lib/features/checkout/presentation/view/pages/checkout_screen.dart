import 'package:flowers_app/config/helper/extensions/base_state/show_error_massage.dart';
import 'package:flowers_app/core/routes/routes.dart';
import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/core/values/app_strings.dart';
import 'package:flowers_app/core/widgets/custom_app_bar.dart';
import 'package:flowers_app/features/checkout/presentation/view/widgets/checkout_address_card.dart';
import 'package:flowers_app/features/checkout/presentation/view/widgets/checkout_delivery_time.dart';
import 'package:flowers_app/features/checkout/presentation/view/widgets/checkout_gift_section.dart';
import 'package:flowers_app/features/checkout/presentation/view/widgets/checkout_payment_method.dart';
import 'package:flowers_app/features/checkout/presentation/view/widgets/checkout_price_section.dart';
import 'package:flowers_app/features/checkout/presentation/view_model/cubit/checkout_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CheckoutScreen extends StatefulWidget {
  final int subtotal;

  const CheckoutScreen({super.key, required this.subtotal});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _receiverNameController = TextEditingController();
  final _receiverPhoneController = TextEditingController();

  @override
  void dispose() {
    _receiverNameController.dispose();
    _receiverPhoneController.dispose();
    super.dispose();
  }

  void _placeOrder() {
    final cubit = context.read<CheckoutCubit>();
    final isCard = cubit.state.selectedPayment == 1;

    if (isCard) {
      cubit.doIntent(
        PlaceOrderWithCardEvent(
          receiverName: _receiverNameController.text,
          receiverPhone: _receiverPhoneController.text,
        ),
      );
    } else {
      cubit.doIntent(const PlaceOrderWithCashEvent());
    }
  }

  void _onOrderStateChanged(BuildContext context, CheckoutStates state) {
    final orderState = state.orderState;
    if (orderState.isError) {
      context.showErrorMessage(orderState);
      return;
    }
    if (!orderState.isSuccess) return;

    final result = orderState.data;
    if (result != null && result.requiresPayment) {
      final url = result.paymentUrl;
      if (url != null && url.isNotEmpty) {
        context.pushNamed(
          Routes.paymentWebView,
          extra: {'url': url, 'successUrl': result.successUrl},
        );
      }
    } else {
      context.pushReplacementNamed(
        Routes.thankYou,
        extra: {'orderId': result?.orderId, 'orderNumber': result?.orderNumber},
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grayEA,
      appBar: CustomAppBar(title: AppStrings.checkoutTitle),
      body: BlocListener<CheckoutCubit, CheckoutStates>(
        listenWhen: (previous, current) =>
            previous.orderState != current.orderState,
        listener: _onOrderStateChanged,
        child: SingleChildScrollView(
          physics: const RangeMaintainingScrollPhysics(),
          child: Column(
            spacing: 24,
            children: [
              const CheckoutDeliveryTime(),
              CheckoutAddressCard(
                addresses: context.read<CheckoutCubit>().state.addresses,
                selectedIndex: context.select<CheckoutCubit, int>(
                  (c) => c.state.selectedAddressIndex,
                ),
                onChanged: (v) => context.read<CheckoutCubit>().doIntent(
                  SelectAddressEvent(v),
                ),
              ),
              CheckoutPaymentMethod(
                selectedIndex: context.select<CheckoutCubit, int>(
                  (c) => c.state.selectedPayment,
                ),
                onChanged: (v) => context.read<CheckoutCubit>().doIntent(
                  ChangePaymentMethodEvent(v),
                ),
              ),
              CheckoutGiftSection(
                nameController: _receiverNameController,
                phoneController: _receiverPhoneController,
              ),
              CheckoutPriceSection(
                subtotal: widget.subtotal,
                onPlaceOrder: _placeOrder,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
