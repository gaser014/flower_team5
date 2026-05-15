import 'package:flowers_app/core/values/app_assets.dart';
import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/features/categories/presentation/view/categories_view.dart';
import 'package:flowers_app/features/home/presentation/view/pages/home_page.dart';
import 'package:flowers_app/features/main/presentation/screens/app_bar_widget.dart';
import 'package:flowers_app/features/main/presentation/screens/profile_appbar.dart';
import 'package:flowers_app/features/main/presentation/view_model/cubit/home_cubit.dart';
import 'package:flowers_app/features/main/presentation/view_model/cubit/home_events.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  late final HomeCubit cubit;
  late final List<Widget> _pages;

  @override
  void initState() {
    cubit = context.read<HomeCubit>();
    _pages = <Widget>[
      const HomePage(),
      CategoriesView(),
      const Center(child: Text('Cart')),
      const Center(child: Text('Profile')),
    ];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeStates>(
      builder: (context, state) {
        final selectedIndex = state.bottomNavIndex;
        return Scaffold(
          appBar: selectedIndex == 0
              ? const AppBarWidget()
              : selectedIndex == 3
              ? const ProfileAppBarWidget()
              : null,
          body: IndexedStack(index: selectedIndex, children: _pages),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: selectedIndex,
            onTap: (index) {
              cubit.doIndented(ChangeBottomNavIndexEvent(index));
            },
            type: BottomNavigationBarType.fixed,
            selectedItemColor: AppColors.primerColor,
            unselectedItemColor: AppColors.grayA6,
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  AppAssets.iconsHome,
                  colorFilter: ColorFilter.mode(
                    selectedIndex == 0
                        ? AppColors.primerColor
                        : AppColors.grayA6,
                    BlendMode.srcIn,
                  ),
                ),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  AppAssets.iconsCategory,
                  colorFilter: ColorFilter.mode(
                    selectedIndex == 1
                        ? AppColors.primerColor
                        : AppColors.grayA6,
                    BlendMode.srcIn,
                  ),
                ),
                label: 'Categories',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  AppAssets.iconsCart,
                  colorFilter: ColorFilter.mode(
                    selectedIndex == 2
                        ? AppColors.primerColor
                        : AppColors.grayA6,
                    BlendMode.srcIn,
                  ),
                ),
                label: 'Cart',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  AppAssets.iconsProfile,
                  colorFilter: ColorFilter.mode(
                    selectedIndex == 3
                        ? AppColors.primerColor
                        : AppColors.grayA6,
                    BlendMode.srcIn,
                  ),
                ),
                label: 'Profile',
              ),
            ],
          ),
        );
      },
    );
  }
}
