import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/values/app_assets.dart';
import '../../../../core/values/app_colors.dart';
import '../../../../core/values/app_font_style.dart';
import '../cubit/categories_cubit.dart';
import '../cubit/categories_state.dart';
import '../widgets/filter_bottom_sheet.dart';

class CategoriesView extends StatefulWidget {
  const CategoriesView({super.key});

  @override
  State<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  String? _selectedFilter;

  @override
  void initState() {
    super.initState();
    context.read<CategoriesCubit>().loadInitialData();
  }

  void _showFilterBottomSheet() async {
    final result = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => FilterBottomSheet(initialSortOption: _selectedFilter),
    );

    if (result != null) {
      setState(() {
        _selectedFilter = result;
      });
      // Optionally trigger search/filter logic here
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        title: Text('Categories',
            style: AppFontStyle.bold18(context: context)
                .copyWith(color: AppColors.black)),
        centerTitle: false,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              // Search Bar & Top Filter
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          context.push(Routes.productSearch);
                        },
                        child: Container(
                          height: 48.h,
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.blackCE),
                            borderRadius: BorderRadius.circular(8.r),
                            color: AppColors.white,
                          ),
                          child: Row(
                            children: [
                              SvgPicture.asset(AppAssets.iconsSearch,
                                  colorFilter: const ColorFilter.mode(
                                      AppColors.grayA6, BlendMode.srcIn),
                                  width: 20.w),
                              SizedBox(width: 8.w),
                              Text('Search',
                                  style: AppFontStyle.regular14(context: context)
                                      .copyWith(color: AppColors.grayA6)),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    GestureDetector(
                      onTap: _showFilterBottomSheet,
                      child: Container(
                        height: 48.h,
                        width: 48.h,
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.blackCE),
                          borderRadius: BorderRadius.circular(8.r),
                          color: AppColors.white,
                        ),
                        child: Center(
                          child: SvgPicture.asset(AppAssets.iconsFilter,
                              colorFilter: const ColorFilter.mode(
                                  AppColors.grayA6, BlendMode.srcIn),
                              width: 20.w),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),

              // Categories Tabs
              BlocBuilder<CategoriesCubit, CategoriesState>(
                builder: (context, state) {
                  List categories = [];
                  String? selectedId;

                  if (state is CategoriesLoaded) {
                    categories = state.categories;
                    selectedId = state.selectedCategoryId;
                  }

                  return SizedBox(
                    height: 40.h,
                    child: ListView.separated(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length + 1,
                      separatorBuilder: (context, index) => SizedBox(width: 24.w),
                      itemBuilder: (context, index) {
                        final isAll = index == 0;
                        final category = isAll ? null : categories[index - 1];
                        final isSelected = isAll
                            ? selectedId == null
                            : selectedId == category?.id;

                        return GestureDetector(
                          onTap: () {
                            context
                                .read<CategoriesCubit>()
                                .selectCategory(isAll ? null : category?.id);
                          },
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                isAll ? 'All' : (category?.name ?? ''),
                                style: AppFontStyle.medium14(context: context)
                                    .copyWith(
                                  color: isSelected
                                      ? AppColors.primerColor
                                      : AppColors.black85,
                                ),
                              ),
                              SizedBox(height: 8.h),
                              Container(
                                height: 2.h,
                                width: 24.w,
                                decoration: BoxDecoration(
                                  color: isSelected ? AppColors.primerColor : AppColors.blackCE,
                                  borderRadius: BorderRadius.circular(100.r),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
              SizedBox(height: 16.h),
              
              // Products Area (Empty for now as requested, but keeping layout)
              Expanded(
                child: BlocBuilder<CategoriesCubit, CategoriesState>(
                  builder: (context, state) {
                    if (state is CategoriesLoading) {
                      return const Center(child: CircularProgressIndicator(color: AppColors.primerColor));
                    }
                    if (state is CategoriesLoaded && state.isLoadingProducts) {
                      return const Center(child: CircularProgressIndicator(color: AppColors.primerColor));
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),

          // Floating Filter Button
          if (_selectedFilter != null)
            Positioned(
              bottom: 24.h,
              left: 16.w,
              right: 16.w,
              child: Center(
                child: GestureDetector(
                  onTap: _showFilterBottomSheet,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                    decoration: BoxDecoration(
                      color: AppColors.primerColor,
                      borderRadius: BorderRadius.circular(100.r),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primerColor.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        )
                      ],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset(
                          AppAssets.iconsFilter,
                          width: 18.w,
                          colorFilter: const ColorFilter.mode(AppColors.white, BlendMode.srcIn),
                        ),
                        SizedBox(width: 12.w),
                        Text(
                          'Filter',
                          style: AppFontStyle.bold16(context: context).copyWith(color: AppColors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
