import 'package:edudibon_flutter_bloc/core/utils/app_styles.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/screen_util_helper.dart';

class TabItemWidget extends StatelessWidget {
  final String title;
  final int index;
  final bool isActive;
  final VoidCallback onTap;

  const TabItemWidget({
    super.key,
    required this.title,
    required this.index,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context);

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: AppStyles.size.bodySmall,
                fontWeight: isActive ? AppStyles.weight.heading : AppStyles.weight.regular,
                color: isActive ? AppColors.secondaryDarkest : AppColors.stone,
              ),
            ),
          ],
        ),
      ),
    );
  }
}