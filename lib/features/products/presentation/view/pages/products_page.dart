import 'package:flowers_app/config/dependency_injection/di.dart';
import 'package:flowers_app/core/values/app_strings.dart';
import 'package:flowers_app/core/widgets/custom_app_bar.dart';
import 'package:flowers_app/features/categories/domain/entities/categories_params.dart';
import 'package:flowers_app/features/categories/presentation/view/widgets/categories_tap_bar.dart';
import 'package:flowers_app/features/categories/presentation/view_model/cubit/categories_cubit.dart';
import 'package:flowers_app/features/products/domain/entities/products_params.dart';
import 'package:flowers_app/features/products/presentation/view/widgets/products_body.dart';
import 'package:flowers_app/features/products/presentation/view_model/cubit/products_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsPage extends StatefulWidget {
  const ProductsPage({super.key});

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  late final CategoriesCubit categoriesCubit;
  late final ProductsCubit productsCubit;

  @override
  void initState() {
    categoriesCubit = getIt<CategoriesCubit>()
      ..doIntent(
        GetAllCategoriesEvent(
          params: CategoriesParams(type: CategoriesType.occasions),
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
            BlocProvider<CategoriesCubit>(
              create: (context) => categoriesCubit,
              child: BlocListener<CategoriesCubit, CategoriesStates>(
                listenWhen: (previous, current) =>
                    previous.selectCategoryState != current.selectCategoryState,
                listener: (context, state) {
                  final category = state.selectCategoryState;
                  if (category != null) {
                    productsCubit.doIntent(
                      GetAllProductsEvent(
                        params: ProductsParams(
                          category: category,
                          type: CategoriesType.occasions,
                        ),
                      ),
                    );
                  }
                },
                child: CategoriesTapBar(
                  onTap: (item) {
                    categoriesCubit.doIntent(
                      SelectCategoryEvent(category: item),
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
