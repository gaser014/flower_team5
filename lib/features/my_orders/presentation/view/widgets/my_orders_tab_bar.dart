import 'package:flowers_app/core/values/app_colors.dart';
import 'package:flowers_app/core/values/app_font_style.dart';
import 'package:flowers_app/core/values/app_strings.dart';
import 'package:flutter/material.dart';

class MyOrdersTabBar extends StatelessWidget {
  const MyOrdersTabBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: DefaultTabController.of(context),
      builder: (context, _) {
        final controller = DefaultTabController.of(context);
        final selectedIndex = controller.index;
        return Row(
          children: List.generate(2, (index) {
            final isSelected = index == selectedIndex;
            final color =
                isSelected ? AppColors.primerColor : AppColors.grayA6;
            return Expanded(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => controller.animateTo(index),
                child: Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        index == 0
                            ? AppStrings.active
                            : AppStrings.completed,
                        textAlign: TextAlign.center,
                        style: AppFontStyle.regular16(context: context)
                            .copyWith(color: color),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        height: 3,
                        decoration: BoxDecoration(
                          color: color,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(100),
                            topRight: Radius.circular(100),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
