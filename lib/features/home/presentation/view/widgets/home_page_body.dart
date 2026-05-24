import 'package:flowers_app/core/routes/routes.dart';
import 'package:flowers_app/core/values/app_strings.dart';
import 'package:flowers_app/features/home/presentation/view/widgets/best_seller_section.dart';
import 'package:flowers_app/features/home/presentation/view/widgets/category_list_section.dart';
import 'package:flowers_app/features/home/presentation/view/widgets/home_shimmer.dart';
import 'package:flowers_app/features/home/presentation/view/widgets/occasion_section.dart';
import 'package:flowers_app/features/home/presentation/view/widgets/section_header.dart';
import 'package:flowers_app/features/main/presentation/view_model/cubit/home_cubit.dart';
import 'package:flowers_app/features/main/presentation/view_model/cubit/home_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class HomePageBody extends StatefulWidget {
  const HomePageBody({super.key});

  @override
  State<HomePageBody> createState() => _HomePageBodyState();
}

class _HomePageBodyState extends State<HomePageBody> {
  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().doIndented(GetAllHomeDataEvent());
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<HomeCubit>();

    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () async {
          cubit.doIndented(GetAllHomeDataEvent());
        },
        child: BlocBuilder<HomeCubit, HomeState>(
          buildWhen: (previous, current) =>
              previous.getAllHomeDataState != current.getAllHomeDataState,
          builder: (context, state) {
            return state.getAllHomeDataState.when(
              initial: () => const SizedBox.shrink(),
              loading: () => const HomeShimmer(),
              error: (error) => Center(child: Text(error.toString())),
              success: (data) {
                final homeData = data;

                return SingleChildScrollView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (homeData.categories?.isNotEmpty ?? false) ...[
                        SectionHeader(
                          title: AppStrings.categories,
                          onViewAllPressed: () =>
                              cubit.doIndented(ChangeBottomNavIndexEvent(1)),
                        ),
                        CategoryListSection(
                          categories: homeData.categories ?? [],
                        ),
                        const Gap(16),
                      ],
                      if (homeData.bestSeller?.isNotEmpty ?? false) ...[
                        SectionHeader(
                          title: AppStrings.bestSeller,
                          onViewAllPressed: () {
                            context.push(Routes.bestSeller);
                          },
                        ),
                        BestSellerSection(products: homeData.bestSeller ?? []),
                        const Gap(16),
                      ],
                      if (homeData.occasions?.isNotEmpty ?? false) ...[
                        SectionHeader(
                          title: AppStrings.occasion,
                          onViewAllPressed: () {
                            context.push(Routes.occasionPage);
                          },
                        ),
                        OccasionSection(occasions: homeData.occasions ?? []),
                      ],
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
