import 'package:easy_localization/easy_localization.dart';
import 'package:flowers_app/config/dependency_injection/di.dart';
import 'package:flowers_app/core/routes/routes.dart';
import 'package:flowers_app/core/routes/app_routes.dart';
import 'package:flowers_app/core/routes/routes.dart';
import 'package:flowers_app/core/values/app_strings.dart';
import 'package:flowers_app/features/order_tracking/domain/entities/order_tracking_args.dart';

import 'package:flowers_app/features/app_language/presentation/view/widgets/language_bottom_sheet.dart';
import 'package:flowers_app/features/logout/presentation/view/widgets/logout_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:flowers_app/core/values/app_assets.dart';
import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/core/values/app_font_style.dart';
import 'package:flowers_app/features/main_profile/presentation/view_model/cubit/main_profile_events.dart';
import 'package:flowers_app/features/main_profile/presentation/view_model/cubit/main_profile_cubit.dart';
import 'package:flowers_app/features/main_profile/presentation/view/widgets/profile_header_widget.dart';
import 'package:flowers_app/features/main_profile/presentation/view/widgets/profile_menu_item_widget.dart';

import 'package:flowers_app/core/constants/app_urls.dart';
import 'package:flowers_app/features/main_profile/presentation/view/pages/web_view_page.dart';
import 'package:flowers_app/features/main_profile/presentation/view/widgets/main_profile_shimmer.dart';
import 'package:go_router/go_router.dart';

class MainProfilePage extends StatelessWidget {
  const MainProfilePage({super.key});
  String _getLanguageString(BuildContext context) {
    if (Localizations.localeOf(context).languageCode == 'ar') {
      return AppStrings.arabic;
    }
    return AppStrings.english;
  }

  void _showLanguageBottomSheet(BuildContext context) {
    final currentLanguage = _getLanguageString(context);
    final cubit = context.read<MainProfileCubit>();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return LanguageBottomSheet(
          initialLanguage: currentLanguage,
          onLanguageSelected: (newLanguage) {
            final code = newLanguage == AppStrings.arabic ? 'ar' : 'en';
            if (code == 'ar') {
              context.setLocale(const Locale('ar', 'EG'));
            } else {
              context.setLocale(const Locale('en', 'US'));
            }
            // Sync the chosen language to this device's FCM token in Firebase.
            cubit.doIndented(ChangeLanguageEvent(code));
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          getIt.get<MainProfileCubit>()..doIndented(GetMainProfileEvent()),
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: BlocBuilder<MainProfileCubit, MainProfileStates>(
                builder: (context, state) {
                  if (state.profileState.isLoading) {
                    return const MainProfileShimmer();
                  } else if (state.profileState.isError) {
                    return Center(
                      child: Text(
                        state.profileState.exception?.toString() ?? "",
                      ),
                    );
                  }

                  if (state.profileState.isSuccess &&
                      state.profileState.data != null) {
                    final user = state.profileState.data!;
                    return RefreshIndicator(
                      onRefresh: () async {
                        context.read<MainProfileCubit>().doIndented(
                          GetMainProfileEvent(),
                        );
                      },
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            ProfileHeaderWidget(user: user),

                            ProfileMenuItemWidget(
                              title: AppStrings.profile,
                              onTap: () {
                                context.push(Routes.editProfile);
                              },
                              trailing: const Icon(
                                Icons.chevron_right,
                                color: AppColors.gray7D,
                              ),
                              icon: null,
                              leadingIconWidget: SvgPicture.asset(
                                AppAssets.iconsProfile,
                                height: 20,
                                colorFilter: const ColorFilter.mode(
                                  AppColors.black32,
                                  BlendMode.srcIn,
                                ),
                              ),
                            ),
                            ProfileMenuItemWidget(
                              title: AppStrings.myOrders,
                              onTap: () {
                                context.push(Routes.myOrders);
                              },
                              trailing: const Icon(
                                Icons.chevron_right,
                                color: AppColors.gray7D,
                              ),
                              icon: null,
                              leadingIconWidget: SvgPicture.asset(
                                AppAssets.iconsTransactionOrder,
                                height: 24,
                              ),
                            ),
                            ProfileMenuItemWidget(
                              title: AppStrings.savedAddresses,
                              onTap: () => context.push(Routes.addresses),
                              trailing: const Icon(
                                Icons.chevron_right,
                                color: AppColors.gray7D,
                              ),
                              icon: null,
                              leadingIconWidget: SvgPicture.asset(
                                AppAssets.iconsLocation,
                                height: 24,
                              ),
                            ),

                            const Divider(
                              color: AppColors.grayEA,
                              thickness: 1,
                            ),

                            ProfileMenuItemWidget(
                              title: AppStrings.notification,
                              onTap: () => context.push(Routes.notifications),
                              trailing: const Icon(
                                Icons.chevron_right,
                                color: AppColors.gray7D,
                              ),
                              icon: null,
                              leadingIconWidget: SvgPicture.asset(
                                AppAssets.iconsNotification,
                                height: 24,
                              ),
                            ),

                            const Divider(
                              color: AppColors.grayEA,
                              thickness: 1,
                            ),

                            ProfileMenuItemWidget(
                              title: AppStrings.language,
                              onTap: () => _showLanguageBottomSheet(context),
                              leadingIconWidget: SvgPicture.asset(
                                AppAssets.iconsTranslateLang,
                                height: 24,
                              ),
                              trailing: Text(
                                context.locale.languageCode == "ar"
                                    ? AppStrings.arabic
                                    : AppStrings.english,
                                style: AppFontStyle.regular14(
                                  context: context,
                                ).copyWith(color: AppColors.primerColor),
                              ),
                            ),
                            ProfileMenuItemWidget(
                              title: AppStrings.aboutUs,
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => WebViewPage(
                                    url: AppUrls.aboutUs.toString(),
                                    title: AppStrings.aboutUs,
                                  ),
                                ),
                              ),
                              leadingIconWidget: const SizedBox(width: 24),
                              trailing: const Icon(
                                Icons.chevron_right,
                                color: AppColors.gray7D,
                              ),
                            ),
                            ProfileMenuItemWidget(
                              title: AppStrings.termsConditions,
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => WebViewPage(
                                    url: AppUrls.termsAndConditions.toString(),
                                    title: AppStrings.termsConditions,
                                  ),
                                ),
                              ),
                              leadingIconWidget: const SizedBox(width: 24),
                              trailing: const Icon(
                                Icons.chevron_right,
                                color: AppColors.gray7D,
                              ),
                            ),

                            const Divider(
                              color: AppColors.grayEA,
                              thickness: 1,
                            ),
                            LogoutButtonWidget(),

                            // Padding(
                            //   padding: const EdgeInsets.symmetric(
                            //     horizontal: 24.0,
                            //     vertical: 16.0,
                            //   ),
                            //   child: Row(
                            //     mainAxisAlignment:
                            //         MainAxisAlignment.spaceBetween,
                            //     children: [
                            //       Row(
                            //         children: [
                            //           SvgPicture.asset(
                            //             AppAssets.iconsLogout,
                            //             height: 24,
                            //           ),
                            //           const Gap(16),
                            //           Text(
                            //             AppStrings.logout,
                            //             style: AppFontStyle.regular16(
                            //               context: context,
                            //             ),
                            //           ),
                            //         ],
                            //       ),
                            //     ],
                            //   ),
                            // ),
                            const SizedBox(height: 40),
                            Text(
                              "v 6.3.0 - (446)",
                              style: AppFontStyle.regular14(
                                context: context,
                              ).copyWith(color: AppColors.gray7D),
                            ),
                            const SizedBox(height: 24),
                          ],
                        ),
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
