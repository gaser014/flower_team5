import 'package:flowers_app/config/dependency_injection/di.dart';
import 'package:flowers_app/core/data/data_sources/auth_local_data_source.dart';
import 'package:flowers_app/core/routes/routes.dart';
import 'package:flowers_app/core/values/app_assets.dart';
import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/core/widgets/custom_button.dart';
import 'package:flowers_app/features/home/presentation/screens/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _selectedIndex = 0;

  static final List<Widget> _pages = <Widget>[
    HomeView(),
    Center(child: Text('Categories')),
    Center(child: Text('Cart')),
    _Profile(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _selectedIndex, children: _pages),
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
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AppAssets.iconsCategory,
              colorFilter: ColorFilter.mode(
                _selectedIndex == 1 ? AppColors.primerColor : AppColors.grayA6,
                BlendMode.srcIn,
              ),
            ),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AppAssets.iconsCart,
              colorFilter: ColorFilter.mode(
                _selectedIndex == 2 ? AppColors.primerColor : AppColors.grayA6,
                BlendMode.srcIn,
              ),
            ),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              AppAssets.iconsProfile,
              colorFilter: ColorFilter.mode(
                _selectedIndex == 3 ? AppColors.primerColor : AppColors.grayA6,
                BlendMode.srcIn,
              ),
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class _Profile extends StatelessWidget {
  const _Profile();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsetsDirectional.all(16),
        child: CustomButton(
          text: "log out",
          variant: ButtonVariant.outlined,
          onPressed: () async {
            await getIt<AuthLocalDataSourceContract>().deleteUserToken();
            if (context.mounted) {
              context.go(Routes.login);
            }
          },
        ),
      ),
    );
  }
}
