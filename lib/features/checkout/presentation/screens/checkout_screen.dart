import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/core/values/app_strings.dart';
import 'package:flowers_app/features/checkout/presentation/cubit/checkout_cubit.dart';
import 'package:flowers_app/features/checkout/presentation/widgets/checkout_address_card.dart';
import 'package:flowers_app/features/checkout/presentation/widgets/checkout_app_bar.dart';
import 'package:flowers_app/features/checkout/presentation/widgets/checkout_delivery_time.dart';
import 'package:flowers_app/features/checkout/presentation/widgets/checkout_gift_section.dart';
import 'package:flowers_app/features/checkout/presentation/widgets/checkout_payment_method.dart';
import 'package:flowers_app/features/checkout/presentation/widgets/checkout_price_section.dart';
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
  int _selectedAddress = 0;

  @override
  void dispose() {
    _receiverNameController.dispose();
    _receiverPhoneController.dispose();
    super.dispose();
  }

  void _placeOrder() {
    final cubit = context.read<CheckoutCubit>();
    final state = cubit.state;
    final isCard = state.selectedPayment == 1;

    if (isCard) {
      cubit.doEvent(
        PlaceOrderWithCard(
          street: state.street,
          phone: state.phone,
          city: state.city,
          lat: '0',
          long: '0',
          receiverName: _receiverNameController.text,
          receiverPhone: _receiverPhoneController.text,
        ),
      );
    } else {
      cubit.doEvent(
        PlaceOrderWithCash(
          street: state.street,
          phone: state.phone,
          city: state.city,
          lat: '0',
          long: '0',
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grayEA,
      appBar: CheckoutAppBar(
        context: context,
        title: AppStrings.checkoutTitle,
      ),
      body: BlocListener<CheckoutCubit, CheckoutState>(
        listenWhen: (previous, current) =>
            previous.status != current.status &&
            (current.status == CheckoutStatus.success ||
                current.status == CheckoutStatus.paymentPending ||
                current.status == CheckoutStatus.error),
        listener: (context, state) {
          switch (state.status) {
            case CheckoutStatus.success:
              context.pushReplacementNamed('thankYou');
            case CheckoutStatus.paymentPending:
              final url = state.paymentUrl;
              if (url != null && url.isNotEmpty) {
                context.pushNamed(
                  'paymentWebView',
                  extra: {'url': url, 'successUrl': state.successUrl},
                );
              }
            case CheckoutStatus.error:
              if (state.errorMessage != null) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.errorMessage!)));
              }
            default:
              break;
          }
        },
        child: SingleChildScrollView(
          physics: const RangeMaintainingScrollPhysics(),
          child: Column(
            spacing: 24,
            children: [
              const CheckoutDeliveryTime(),
              CheckoutAddressCard(
                selectedIndex: _selectedAddress,
                onChanged: (v) => setState(() => _selectedAddress = v),
              ),
              CheckoutPaymentMethod(
                selectedIndex: context.select<CheckoutCubit, int>(
                  (c) => c.state.selectedPayment,
                ),
                onChanged: (v) =>
                    context.read<CheckoutCubit>().doEvent(ChangePaymentMethod(v)),
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
