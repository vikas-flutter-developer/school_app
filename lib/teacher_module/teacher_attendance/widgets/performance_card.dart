import 'package:edudibon_flutter_bloc/core/utils/app_colors.dart';
import 'package:edudibon_flutter_bloc/core/utils/app_styles.dart' show AppStyles;
import 'package:flutter/material.dart';
import 'package:edudibon_flutter_bloc/core/utils/screen_util_helper.dart'; // Import the helper

class PerformanceCard extends StatelessWidget {
  final String titleLine1;
  final String titleLine2;
  final String iconAssetPath;

  const PerformanceCard({
    super.key,
    required this.titleLine1,
    required this.titleLine2,
    required this.iconAssetPath,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: ScreenUtilHelper.width(30),  // ScreenUtilHelper
        right: ScreenUtilHelper.width(30), // ScreenUtilHelper
      ),
      child: Container(
        width: ScreenUtilHelper.width(380),   // ScreenUtilHelper
        height: ScreenUtilHelper.height(88),  // ScreenUtilHelper
        padding: EdgeInsets.symmetric(
          horizontal: ScreenUtilHelper.width(16.0),  // ScreenUtilHelper
          vertical: ScreenUtilHelper.height(18.0),   // ScreenUtilHelper
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(5.0)), // ScreenUtilHelper
          border: Border.all(
            color: AppColors.primaryContrast,
            width: ScreenUtilHelper.width(1), // ScreenUtilHelper
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  titleLine1,
                  style: TextStyle(
                    fontSize: ScreenUtilHelper.fontSize(AppStyles.size.bodySmall), // ScreenUtilHelper
                    fontWeight: AppStyles.weight.emphasis,
                    color: AppColors.black,
                  ),
                ),
                SizedBox(height: ScreenUtilHelper.height(4)), // ScreenUtilHelper
                Text(
                  titleLine2,
                  style: TextStyle(
                    fontSize: ScreenUtilHelper.fontSize(AppStyles.size.bodySmall), // ScreenUtilHelper
                    fontWeight: AppStyles.weight.emphasis,
                    color: AppColors.black,
                  ),
                ),
              ],
            ),
            Image.asset(
              iconAssetPath,
              height: ScreenUtilHelper.height(73), // ScreenUtilHelper
              width: ScreenUtilHelper.width(73),   // ScreenUtilHelper
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }
}
