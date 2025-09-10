import '../../../core/utils/app_decorations.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_styles.dart';
import '../../../core/utils/screen_util_helper.dart';

class SyllabusCard extends StatelessWidget {
  final String heading;
  final String description;
  final VoidCallback onViewMorePressed;
  final Color backgroundColor;

  const SyllabusCard({super.key, 
    required this.heading,
    required this.description,
    required this.onViewMorePressed,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(ScreenUtilHelper.scaleWidth(8.0)),
      elevation: 4.0,
      color: backgroundColor,
      child: Padding(
        padding:  EdgeInsets.all(ScreenUtilHelper.scaleWidth(16.0))
        ,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              heading,
              style: AppStyles.heading,
            ),
            SizedBox(height: ScreenUtilHelper.scaleHeight(8)),
            Text(
              description,
              style: AppStyles.bodySmall.copyWith(color: AppColors.black),
            ),
            SizedBox(height: ScreenUtilHelper.scaleHeight(12)),
            LinearProgressIndicator(
              value: 0.5, // Fixed completion value of 1.0 (100%)
              backgroundColor: AppColors.cloud, // Assuming this is defined in your app colors
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.tertiary),
            ),
            SizedBox(height: ScreenUtilHelper.scaleHeight(8)),
            Text(
              '1 Chapter Completed', // Fixed text
              style: AppStyles.small,
            ),
            SizedBox(height: ScreenUtilHelper.scaleHeight(8)),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.black, width: ScreenUtilHelper.scaleWidth(1)),
                  borderRadius: AppDecorations.largeRadius,
                ),
                child: TextButton(
                  onPressed: onViewMorePressed,
                  child: Text('View More'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}