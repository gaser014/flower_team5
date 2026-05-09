import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/routes/routes.dart';
import '../../../../core/values/app_assets.dart';
import '../../../../core/values/app_colors.dart';
import '../../../../core/values/app_font_style.dart';
import '../widgets/filter_bottom_sheet.dart';

class CategoriesView extends StatefulWidget {
  const CategoriesView({super.key});

  @override
  State<CategoriesView> createState() => _CategoriesViewState();
}

class _CategoriesViewState extends State<CategoriesView> {
  void _showFilterBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const FilterBottomSheet(),
    );
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
      body: Column(
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
                      height: 40.h,
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.grayEA),
                        borderRadius: BorderRadius.circular(8.r),
                        color: AppColors.white,
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset(AppAssets.iconsSearch,
                              colorFilter: const ColorFilter.mode(
                                  AppColors.grayA6, BlendMode.srcIn),
                              width: 16.w),
                          SizedBox(width: 8.w),
                          Text('Search',
                              style:
                                  AppFontStyle.regular14(context: context)
                                      .copyWith(color: AppColors.grayA6)),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 16.w),
                GestureDetector(
                  onTap: _showFilterBottomSheet,
                  child: Container(
                    height: 40.h,
                    width: 40.h,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.grayEA),
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
          SizedBox(height: 16.h),
        ],
      ),
    );
  }
}
