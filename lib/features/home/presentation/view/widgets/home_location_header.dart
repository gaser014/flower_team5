import 'package:flowers_app/core/routes/routes.dart';
import 'package:flowers_app/core/values/app_assets.dart';
import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/core/values/app_font_style.dart';
import 'package:flowers_app/core/values/app_strings.dart';
import 'package:flowers_app/features/location/presentation/cubit/location_cubit.dart';
import 'package:flowers_app/features/location/presentation/cubit/location_states.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class HomeLocationHeader extends StatelessWidget {
  const HomeLocationHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationCubit, LocationState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: () => context.pushNamed(Routes.addresses),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                SvgPicture.asset(
                  AppAssets.iconsLocation,
                  height: 20,
                  width: 20,
                  colorFilter: const ColorFilter.mode(
                    AppColors.black32,
                    BlendMode.srcIn,
                  ),
                ),
                const Gap(8),
                switch (state) {
                  LocationLoading() => SizedBox(
                    height: 14,
                    width: 14,
                    child: CupertinoActivityIndicator(),
                  ),
                  LocationLoaded(:final selectedAddress) => Expanded(
                    child: Text(
                      '${AppStrings.deliverTo} ${selectedAddress.street ?? ''}, ${selectedAddress.city ?? ''}',
                      style: AppFontStyle.medium14(
                        context: context,
                      ).copyWith(color: AppColors.black32),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  LocationEmpty(:final message) => Text(
                    '${AppStrings.deliverTo} $message',
                    style: AppFontStyle.medium14(
                      context: context,
                    ).copyWith(color: AppColors.grayA6),
                    overflow: TextOverflow.ellipsis,
                  ),
                  LocationError() => Text(
                    '${AppStrings.deliverTo} —',
                    style: AppFontStyle.medium14(
                      context: context,
                    ).copyWith(color: AppColors.grayA6),
                    overflow: TextOverflow.ellipsis,
                  ),
                  _ => Text(
                    '${AppStrings.deliverTo} ...',
                    style: AppFontStyle.medium14(
                      context: context,
                    ).copyWith(color: AppColors.black32),
                    overflow: TextOverflow.ellipsis,
                  ),
                },
                const Gap(4),
                if (state is LocationLoaded)
                  SvgPicture.asset(
                    AppAssets.iconsDownArrow,
                    height: 10,
                    width: 10,
                    colorFilter: const ColorFilter.mode(
                      AppColors.primerColor,
                      BlendMode.srcIn,
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
