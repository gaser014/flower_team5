import 'package:flowers_app/core/values/app_assets.dart';
import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/core/values/app_font_style.dart';
import 'package:flutter/material.dart';

class MyOrdersPageBody extends StatelessWidget {
  const MyOrdersPageBody({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: AppColors.grayEA, width: 2),
              ),
            ),
            child: TabBar(
              indicatorColor: AppColors.primerColor,
              indicatorWeight: 2,
              indicatorSize: TabBarIndicatorSize.tab,
              labelColor: AppColors.primerColor,
              unselectedLabelColor: AppColors.grayA6,
              labelStyle: AppFontStyle.medium16(context: context),
              unselectedLabelStyle: AppFontStyle.medium16(context: context),
              tabs: const [
                Tab(text: "Active"),
                Tab(text: "Completed"),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: 2,
                  itemBuilder: (context, index) {
                    return const _OrderItemCard();
                  },
                ),
                Center(
                  child: Text(
                    "No completed orders yet",
                    style: AppFontStyle.regular16(
                      context: context,
                    ).copyWith(color: AppColors.gray7D),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _OrderItemCard extends StatelessWidget {
  const _OrderItemCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.grayA6.withValues(alpha: 0.5)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(8),
              bottomLeft: Radius.circular(8),
            ),
            child: Container(
              width: 130,
              height: 140,
              color: AppColors.pinkF9,
              child: Image.asset(
                AppAssets.splashLogo,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.image,
                    color: AppColors.pinkF0,
                    size: 40,
                  );
                },
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Content
          Expanded(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 16, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Red roses",
                    style: AppFontStyle.regular16(
                      context: context,
                    ).copyWith(color: AppColors.black32),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "EGP 600",
                    style: AppFontStyle.semiBold16(
                      context: context,
                    )?.copyWith(color: AppColors.black),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    "Order number# 123456",
                    style: AppFontStyle.regular14(
                      context: context,
                    ).copyWith(color: AppColors.gray7D),
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      height: 36,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primerColor,
                          foregroundColor: AppColors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 24),
                        ),
                        child: Text(
                          "Track order",
                          style: AppFontStyle.medium14(
                            context: context,
                          ).copyWith(color: AppColors.white),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
