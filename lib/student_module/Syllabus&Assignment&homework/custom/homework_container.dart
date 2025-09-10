import '../../../core/utils/app_decorations.dart';
import 'package:flutter/material.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_styles.dart';
import '../../../core/utils/screen_util_helper.dart';

class HomeworkContainer extends StatelessWidget {
  final String title;
  final String description;

  const HomeworkContainer({super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: AppDecorations.smallMargin,
      padding: AppDecorations.mediumPadding,
      decoration: BoxDecoration(
        color: AppColors.ivory,
        borderRadius: AppDecorations.normalRadius,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppStyles.heading,
          ),
          SizedBox(height: ScreenUtilHelper.scaleHeight(8)),
          Text(description),
          // Add more homework details here
        ],
      ),
    );
  }
}