import 'package:edudibon_flutter_bloc/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import '../../../core/utils/app_styles.dart';
import '../../../core/utils/screen_util_helper.dart';
import '../model/student_fee_record.dart';

class StatusChip extends StatelessWidget {
  final FeeStatus status;

  const StatusChip({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context);
    String text;
    Color color;
    Color textColor = AppColors.white; // Generally white text looks good

    switch (status) {
      case FeeStatus.Paid:
        text = "Paid";
        color = Colors.green.shade400;
        break;
      case FeeStatus.Unpaid:
        text = "Unpaid";
        color = AppColors.pending;
        break;
      case FeeStatus.Overdue:
        text = "Overdue";
        color = AppColors.error;
        break;
    }

    return Chip(
      label: Text(
        text,
        style: TextStyle(
          color: textColor,
          fontSize: ScreenUtilHelper.scaleText(AppStyles.size.tiny), //  Responsive font size
          fontWeight: FontWeight.w500,
        ),
      ),
      backgroundColor: color,
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtilHelper.scaleWidth(8.0), //  Responsive horizontal
        vertical: ScreenUtilHelper.scaleHeight(2.0),   //  Responsive vertical
      ),
      labelPadding: EdgeInsets.zero, // Adjust padding if needed
      visualDensity: VisualDensity.compact, // Make chip smaller
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }
}
