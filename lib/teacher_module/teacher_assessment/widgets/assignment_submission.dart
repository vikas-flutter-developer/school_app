import 'package:edudibon_flutter_bloc/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import '../../../core/utils/app_styles.dart';
import '../../../core/utils/screen_util_helper.dart';

class AssignmentSubmission extends StatelessWidget {
  final String name;
  final double progress;
  final String status;
  final String grade;
  final String feedback;
  final String imagePath;

  const AssignmentSubmission({
    super.key,
    required this.name,
    required this.progress,
    required this.status,
    required this.grade,
    required this.feedback,
    required this.imagePath,
  });

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'on time':
        return AppColors.success;
      case 'late':
        return AppColors.error;
      case 'in complete':
        return AppColors.warningAccent;
      default:
        return AppColors.black;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: ScreenUtilHelper.scaleWidth(30),
        bottom: ScreenUtilHelper.scaleHeight(30),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                width: ScreenUtilHelper.scaleWidth(15),
                height: ScreenUtilHelper.scaleWidth(15),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(
                    ScreenUtilHelper.scaleRadius(15),
                  ),
                  child: Image.asset(imagePath, fit: BoxFit.cover),
                ),
              ),
              SizedBox(width: ScreenUtilHelper.scaleWidth(10)),
              Text(
                name,
                style: AppStyles.body14Black.copyWith(
                  fontSize: ScreenUtilHelper.scaleText(14),
                ),
              ),
              SizedBox(width: ScreenUtilHelper.scaleWidth(15)),
              SizedBox(
                width: ScreenUtilHelper.scaleWidth(78),
                height: ScreenUtilHelper.scaleHeight(3),
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: ScreenUtilHelper.scaleHeight(3),
                  backgroundColor: AppColors.cloud,
                  color: AppColors.attendancePresent,
                ),
              ),
              SizedBox(width: ScreenUtilHelper.scaleWidth(25)),
              SizedBox(
                width: ScreenUtilHelper.scaleWidth(67),
                height: ScreenUtilHelper.scaleHeight(16),
                child: Text(
                  status,
                  style: AppStyles.status(_getStatusColor(status)).copyWith(
                    fontSize: ScreenUtilHelper.scaleText(12),
                  ),
                ),
              ),
              SizedBox(width: ScreenUtilHelper.scaleWidth(10)),
              Text(
                grade,
                style: AppStyles.body14Black.copyWith(
                  fontSize: ScreenUtilHelper.scaleText(14),
                ),
              ),
            ],
          ),
          SizedBox(height: ScreenUtilHelper.scaleHeight(5)),
          Padding(
            padding: EdgeInsets.only(left: ScreenUtilHelper.scaleWidth(25)),
            child: Row(
              children: [
                Flexible(
                  child: Text(
                    feedback,
                    style: AppStyles.feedbackNote.copyWith(
                      fontSize: ScreenUtilHelper.scaleText(12),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
