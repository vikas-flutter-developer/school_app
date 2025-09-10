import 'package:flutter/material.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_styles.dart';
import '../../../core/utils/screen_util_helper.dart';
import 'package:go_router/go_router.dart';

class CustomTabBar extends StatelessWidget {
  final List<String> tabs;
  final int selectedIndex;
  final Function(int) onTabSelected;

  const CustomTabBar({
    Key? key,
    required this.tabs,
    required this.selectedIndex,
    required this.onTabSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtilHelper.scaleWidth(8),
      ),
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              size: ScreenUtilHelper.scaleWidth(20),
            ),
            onPressed: () => GoRouter.of(context).pop(),
          ),

          /// All Tabs fit equally here
          Expanded(
            child: Container(
              height: ScreenUtilHelper.scaleHeight(40),
              decoration: BoxDecoration(
                color: AppColors.accentLight,
                borderRadius: BorderRadius.circular(
                  ScreenUtilHelper.scaleRadius(8),
                ),
              ),
              child: Row(
                children: List.generate(tabs.length, (index) {
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => onTabSelected(index),
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border(
                            right: index < tabs.length - 1
                                ? BorderSide(color: AppColors.black)
                                : BorderSide.none,
                          ),
                        ),
                        child: Text(
                          tabs[index],
                          textAlign: TextAlign.center,
                          style: AppStyles.tabLabel(selectedIndex == index),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
