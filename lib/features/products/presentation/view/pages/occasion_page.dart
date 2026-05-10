import 'package:flowers_app/config/dependency_injection/di.dart';
import 'package:flowers_app/core/values/app_strings.dart';
import 'package:flowers_app/core/widgets/custom_app_bar.dart';
import 'package:flowers_app/features/app_filter_tabs/domain/entities/app_filter_tabs_params.dart';
import 'package:flowers_app/features/app_filter_tabs/presentation/view/widgets/app_filter_tabs_bar.dart';
import 'package:flowers_app/features/app_filter_tabs/presentation/view_model/cubit/app_filter_tabs_cubit.dart';
import 'package:flowers_app/features/products/domain/entities/products_params.dart';
import 'package:flowers_app/features/products/presentation/view/widgets/products_body.dart';
import 'package:flowers_app/features/products/presentation/view_model/cubit/products_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OccasionPage extends StatefulWidget {
  const OccasionPage({super.key});

  @override
  State<OccasionPage> createState() => _OccasionPageState();
}

class _OccasionPageState extends State<OccasionPage> {
  late final AppFilterTabsCubit appFilterTabsCubit;
  late final ProductsCubit productsCubit;

  @override
  void initState() {
    appFilterTabsCubit = getIt<AppFilterTabsCubit>()
      ..doIntent(
        GetAllAppFilterTabsEvent(
          params: AppFilterTabsParams(type: AppFilterTabsType.occasions),
        ),
      );
    productsCubit = getIt<ProductsCubit>();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppStrings.occasion,
        subTitle: AppStrings.occasionSubTitle,
      ),
      body: SafeArea(
        child: Column(
          children: [
            BlocProvider<AppFilterTabsCubit>(
              create: (context) => appFilterTabsCubit,
              child: BlocListener<AppFilterTabsCubit, AppFilterTabsStates>(
                listenWhen: (previous, current) =>
                    previous.selectCategoryState != current.selectCategoryState,
                listener: (context, state) {
                  final category = state.selectCategoryState;
                  if (category != null) {
                    productsCubit.doIntent(
                      GetAllProductsEvent(
                        params: ProductsParams(
                          category: category,
                          type: AppFilterTabsType.occasions,
                        ),
                      ),
                    );
                  }
                },
                child: AppFilterTabsBar(
                  onTap: (item) {
                    appFilterTabsCubit.doIntent(
                      SelectAppFilterTabEvent(category: item),
                    );
                  },
                ),
              ),
            ),
            Expanded(
              child: BlocProvider<ProductsCubit>(
                create: (context) => productsCubit,
                child: const ProductsBody(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
