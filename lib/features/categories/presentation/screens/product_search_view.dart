import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/values/app_assets.dart';
import '../../../../core/values/app_colors.dart';
import '../../../../core/values/app_font_style.dart';

class ProductSearchView extends StatefulWidget {
  const ProductSearchView({super.key});

  @override
  State<ProductSearchView> createState() => _ProductSearchViewState();
}

class _ProductSearchViewState extends State<ProductSearchView> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Container(
          height: 48.h,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.grayCF),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: TextField(
            controller: _searchController,
            autofocus: true,
            decoration: InputDecoration(
              hintText: 'Search',
              hintStyle: AppFontStyle.regular14(context: context).copyWith(color: AppColors.grayA6),
              prefixIcon: Padding(
                padding: EdgeInsets.all(12.w),
                child: SvgPicture.asset(AppAssets.iconsSearch, colorFilter: const ColorFilter.mode(AppColors.grayA6, BlendMode.srcIn)),
              ),
              suffixIcon: IconButton(
                icon: Icon(Icons.cancel_outlined, color: AppColors.grayA6, size: 20.w),
                onPressed: () {
                  _searchController.clear();
                },
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 12.h),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel', style: AppFontStyle.medium14(context: context).copyWith(color: AppColors.primerColor)),
          ),
          SizedBox(width: 8.w),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Search For Any Product You Want',
              style: AppFontStyle.medium16(context: context).copyWith(color: AppColors.primerColor),
            ),
          ],
        ),
      ),
    );
  }
}
