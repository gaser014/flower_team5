import 'package:flowers_app/config/dependency_injection/di.dart';
import 'package:flowers_app/core/values/app_strings.dart';
import 'package:flowers_app/core/widgets/custom_app_bar.dart';
import 'package:flowers_app/features/addresses/presentation/cubit/addresses_cubit.dart';
import 'package:flowers_app/features/addresses/presentation/widgets/addresses_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddressesPage extends StatelessWidget {
  const AddressesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: AppStrings.savedAddresses),
      body: SafeArea(
        child: BlocProvider<AddressesCubit>(
          create: (context) =>
              getIt<AddressesCubit>()..doIntent(const GetAddressesEvent()),
          child: const AddressesBody(),
        ),
      ),
    );
  }
}
