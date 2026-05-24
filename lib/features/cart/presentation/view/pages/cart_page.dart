import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/features/cart/domain/entities/cart_entity.dart';
import 'package:flowers_app/features/cart/presentation/view/widgets/cart_empty_widget.dart';
import 'package:flowers_app/features/cart/presentation/view/widgets/cart_page_with_data.dart';
import 'package:flowers_app/features/cart/presentation/view/widgets/not_autenthicated_user_widget.dart';
import 'package:flowers_app/features/cart/presentation/view_model/cubit/cart_cubit.dart';
import 'package:flowers_app/features/cart/presentation/view_model/cubit/cart_events.dart';
import 'package:flowers_app/features/cart/presentation/view_model/cubit/cart_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    context.read<CartCubit>().doIntent(GetCartDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      backgroundColor: AppColors.whiteF9,
      body: SafeArea(
        child: BlocBuilder<CartCubit, CartStates>(
          buildWhen: (previous, current) => previous.state != current.state,
          builder: (context, state) {
            return state.state.when(
              initial: () => const Center(child: CircularProgressIndicator()),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (_) => const NotAuthenticatedUserWidget(),
              success: (CartEntity data) {
                if (data.isEmpty) return const CartEmptyWidget();
                return const CartPageWithData();
              },
            );
          },
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
