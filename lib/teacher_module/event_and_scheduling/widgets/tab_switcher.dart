import 'package:flutter/material.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_styles.dart';
import '../../../core/utils/screen_util_helper.dart';

class TabSwitcher extends StatelessWidget {
  final int selectedIndex;
  final List<String> tabs;
  final ValueChanged<int> onTabSelected;

  const TabSwitcher({
    super.key,
    required this.selectedIndex,
    required this.tabs,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtilHelper.scaleHeight(40),
      decoration: BoxDecoration(
        color: AppColors.secondaryAccentLight,
        borderRadius: BorderRadius.circular(ScreenUtilHelper.scaleRadius(5)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: tabs.asMap().entries.map((entry) {
          int index = entry.key;
          String tab = entry.value;
          bool isSelected = selectedIndex == index;

          return Expanded(
            child: GestureDetector(
              onTap: () => onTabSelected(index),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius:
                  BorderRadius.circular(ScreenUtilHelper.scaleRadius(5)),
                  onTap: () => onTabSelected(index),
                  child: Container(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Center(
                          child: Text(
                            tab,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: isSelected
                                  ? AppColors.primaryMedium
                                  : AppColors.slate,
                              fontWeight: AppStyles.weight.heading,
                              fontSize: ScreenUtilHelper
                                  .scaleText(AppStyles.size.body),
                            ),
                          ),
                        ),
                        if (index < tabs.length - 1)
                          Positioned(
                            right: ScreenUtilHelper.scaleWidth(0),
                            top: ScreenUtilHelper.scaleHeight(8),
                            bottom: ScreenUtilHelper.scaleHeight(8),
                            child: VerticalDivider(
                              color: AppColors.blackDisabled,
                              thickness: ScreenUtilHelper.scaleWidth(1),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
