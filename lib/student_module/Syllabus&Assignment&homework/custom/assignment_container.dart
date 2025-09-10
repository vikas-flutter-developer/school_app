import 'package:go_router/go_router.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_decorations.dart';
import 'package:edudibon_flutter_bloc/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import '../../../core/utils/screen_util_helper.dart';
import '../../../routes/app_routes.dart';
import '../submit_screen.dart';


class AssignmentContainer extends StatelessWidget {
  final String title;
  final String issueDate;
  final String description;
  final String lastDate;

  const AssignmentContainer({super.key,
    required this.title,
    required this.issueDate,
    required this.description,
    required this.lastDate,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: AppDecorations.smallMargin,
      padding: AppDecorations.smallMargin,
      decoration: BoxDecoration(
        color: AppColors.ivory,
        borderRadius: AppDecorations.normalRadius,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Issued on $issueDate',
            style: AppStyles.bodySmall.copyWith(color:AppColors.ash),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: AppStyles.heading,
              ),
            ],
          ),
          SizedBox(height: ScreenUtilHelper.scaleHeight(6.0)),
          Text(description),
          SizedBox(height: ScreenUtilHelper.scaleHeight(6.0)),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Last Date: $lastDate'),
              OutlinedButton(
                onPressed: ()=>context.push(AppRoutes.submitHomeWork),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(color: AppColors.black, width: ScreenUtilHelper.scaleWidth(1.0)),

                  shape: RoundedRectangleBorder(
                    borderRadius: AppDecorations.largeRadius,
                  ),
                ),
                child: Text(
                  'Submit',
                  style: TextStyle(fontSize: AppStyles.size.tiny),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}