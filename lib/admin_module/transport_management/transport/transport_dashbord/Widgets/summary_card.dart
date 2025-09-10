import 'package:flutter/material.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/app_decorations.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../../../core/utils/screen_util_helper.dart';

class SummaryCard extends StatelessWidget {
  final String title;
  final String count;

  const SummaryCard({
    Key? key,
    required this.title,
    required this.count,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Initialize ScreenUtilHelper if it hasn't been already
    ScreenUtilHelper.init(context);

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtilHelper.width(16.0),   // <-- Scaled
        vertical: ScreenUtilHelper.height(20.0),     // <-- Scaled
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: AppDecorations.mediumRadius,
        border: Border.all(
          color: AppColors.linen,
          width: ScreenUtilHelper.scaleAll(1.5), // <-- Scaled
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppStyles.body.copyWith(
              color: AppColors.slate,
              fontSize: ScreenUtilHelper.fontSize(15), // <-- Scaled
            ),
          ),
          SizedBox(height: ScreenUtilHelper.height(8)), // <-- Scaled
          Text(
            count,
            style: AppStyles.display.copyWith(
              fontSize: ScreenUtilHelper.fontSize(32), // <-- Scaled
              color: AppColors.black,
            ),
          ),
        ],
      ),
    );
  }
}
