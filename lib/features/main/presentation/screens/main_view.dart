import 'package:flowers_app/core/values/app_assets.dart';
import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/features/home/presentation/screens/home_view.dart';
import 'package:flowers_app/features/app_language/presentation/view/pages/app_language_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _selectedIndex = 0;

  static const List<Widget> _pages = <Widget>[
    HomeView(),
    Center(child: Text('Categories')),
    Center(child: Text('Cart')),
    AppLanguagePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.primerColor,
        unselectedItemColor: AppColors.grayA6,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AppAssets.iconsHome,
              colorFilter: ColorFilter.mode(
                _selectedIndex == 0 ? AppColors.primerColor : AppColors.grayA6,
                BlendMode.srcIn,
              ),
            ),
            label: 'Home'.tr(),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AppAssets.iconsCategory,
              colorFilter: ColorFilter.mode(
                _selectedIndex == 1 ? AppColors.primerColor : AppColors.grayA6,
                BlendMode.srcIn,
              ),
            ),
            label: 'Categories'.tr(),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AppAssets.iconsCart,
              colorFilter: ColorFilter.mode(
                _selectedIndex == 2 ? AppColors.primerColor : AppColors.grayA6,
                BlendMode.srcIn,
              ),
            ),
            label: 'Cart'.tr(),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AppAssets.iconsProfile,
              colorFilter: ColorFilter.mode(
                _selectedIndex == 3 ? AppColors.primerColor : AppColors.grayA6,
                BlendMode.srcIn,
              ),
            ),
            label: 'Profile'.tr(),
          ),
        ],
      ),
    );
  }
}
