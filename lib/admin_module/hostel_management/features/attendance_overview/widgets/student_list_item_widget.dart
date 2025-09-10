import 'package:edudibon_flutter_bloc/core/utils/app_styles.dart';
import 'package:flutter/material.dart';

import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/screen_util_helper.dart';
import '../models/student_short_info_model.dart';

class StudentListItemWidget extends StatelessWidget {
  final StudentShortInfoModel student;

  const StudentListItemWidget({super.key, required this.student});

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context);

    return Padding(
      padding: EdgeInsets.only(bottom: ScreenUtilHelper.height(20)),
      child: Container(
        width: double.infinity,
        height: ScreenUtilHelper.height(40),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(6)),
          color: AppColors.ivory,
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: ScreenUtilHelper.width(16.0)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  student.roomSeat,
                  style: AppStyles.bodyEmphasis.copyWith(color: AppColors.black)
                ),
                Text(
                  student.name,
                  style: AppStyles.bodyEmphasis.copyWith(color: AppColors.black)
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}