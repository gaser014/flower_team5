import 'package:flowers_app/config/dependency_injection/di.dart';
import 'package:flowers_app/core/routes/routes.dart';
import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/core/values/app_strings.dart';
import 'package:flowers_app/features/addresses/domain/entities/address_entity.dart';
import 'package:flowers_app/features/addresses/presentation/cubit/addresses_cubit.dart';
import 'package:flowers_app/features/cart/presentation/view_model/cubit/cart_cubit.dart';
import 'package:flowers_app/features/cart/presentation/view_model/cubit/cart_events.dart';
import 'package:flowers_app/features/checkout/presentation/cubit/checkout_cubit.dart';
import 'package:flowers_app/features/location/presentation/cubit/location_cubit.dart';
import 'package:flowers_app/features/location/presentation/cubit/location_states.dart';
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
  void initState() {
    super.initState();
    context.read<CheckoutCubit>().doEvent(const LoadAddresses());
  }

  @override
  void dispose() {
    _receiverNameController.dispose();
    _receiverPhoneController.dispose();
    super.dispose();
  }

  void _placeOrder() {
    final cubit = context.read<CheckoutCubit>();
    final state = cubit.state;
    final addresses = state.addresses;
    if (_selectedAddress >= addresses.length) return;
    final selectedAddress = addresses[_selectedAddress];
    final isCard = state.selectedPayment == 1;

    if (isCard) {
      cubit.doEvent(
        PlaceOrderWithCard(
          street: selectedAddress.street ?? '',
          phone: selectedAddress.phone ?? '',
          city: selectedAddress.city ?? '',
          lat: selectedAddress.lat ?? '0',
          long: selectedAddress.long ?? '0',
          receiverName: _receiverNameController.text,
          receiverPhone: _receiverPhoneController.text,
        ),
      );
    } else {
      cubit.doEvent(
        PlaceOrderWithCash(
          street: selectedAddress.street ?? '',
          phone: selectedAddress.phone ?? '',
          city: selectedAddress.city ?? '',
          lat: selectedAddress.lat ?? '0',
          long: selectedAddress.long ?? '0',
        ),
      );
    }
  }

  void _syncSelectedAddress(List<AddressEntity> addresses) {
    if (!mounted || addresses.isEmpty) return;
    final locationState = context.read<LocationCubit>().state;
    if (locationState is LocationLoaded) {
      final idx = addresses.indexOf(locationState.selectedAddress);
      if (idx >= 0 && idx != _selectedAddress) {
        setState(() => _selectedAddress = idx);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.grayEA,
      appBar: CheckoutAppBar(context: context, title: AppStrings.checkout),
      body: BlocListener<CheckoutCubit, CheckoutState>(
        listenWhen: (previous, current) =>
            previous.status != current.status &&
            (current.status == CheckoutStatus.success ||
                current.status == CheckoutStatus.paymentPending ||
                current.status == CheckoutStatus.error),
        listener: (context, state) {
          switch (state.status) {
            case CheckoutStatus.success:
              getIt<CartCubit>().doIntent(ClearUserCartEvent());
              context.pushReplacementNamed(Routes.thankYou);
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
        child: BlocListener<CheckoutCubit, CheckoutState>(
          listenWhen: (prev, curr) => prev.addresses != curr.addresses,
          listener: (context, state) => _syncSelectedAddress(state.addresses),
          child: BlocBuilder<CheckoutCubit, CheckoutState>(
            buildWhen: (prev, curr) => prev.addresses != curr.addresses,
            builder: (context, state) {
              final addresses = state.addresses;
              return SingleChildScrollView(
                physics: const RangeMaintainingScrollPhysics(),
                child: Column(
                  spacing: 24,
                  children: [
                    const CheckoutDeliveryTime(),
                    CheckoutAddressCard(
                      selectedIndex: _selectedAddress,
                      addresses: addresses,
                      onChanged: (v) => setState(() => _selectedAddress = v),
                      onShowAllAddresses: () =>
                          context.pushNamed(Routes.addresses),
                      onAddNewAddress: () => context.pushNamed(
                        Routes.addAddress,
                        extra: <String, dynamic>{
                          'editAddress': null,
                          'cubit': getIt<AddressesCubit>(),
                        },
                      ),
                    ),
                    CheckoutPaymentMethod(
                      selectedIndex: context.select<CheckoutCubit, int>(
                        (c) => c.state.selectedPayment,
                      ),
                      onChanged: (v) => context.read<CheckoutCubit>().doEvent(
                        ChangePaymentMethod(v),
                      ),
                    ),
                    CheckoutGiftSection(
                      usernameController: _receiverNameController,
                      phoneController: _receiverPhoneController,
                    ),
                    CheckoutPriceSection(
                      subtotal: widget.subtotal,
                      onPlaceOrder: _placeOrder,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
