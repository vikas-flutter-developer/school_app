import 'package:edudibon_flutter_bloc/teacher_module/teacher_attendance/models/student_model.dart' show Students;
import 'package:flutter/material.dart';

import '../../../core/utils/app_colors.dart';
import '../../../core/utils/app_styles.dart';
import '../../../core/utils/screen_util_helper.dart'; // ✅ Import ScreenUtilHelper

class AttendanceCard extends StatelessWidget {
  final Students student;
  final Function(String)? onStatusChanged;

  const AttendanceCard({Key? key, required this.student, this.onStatusChanged})
      : super(key: key);

  Map<String, dynamic> _getStatusStyle(String status) {
    switch (status.toUpperCase()) {
      case 'P':
      case 'PRESENT':
        return {'text': 'P', 'color': AppColors.successDark};
      case 'A':
      case 'ABSENT':
        return {'text': 'A', 'color': AppColors.error};
      case 'L':
      case 'LATE':
        return {'text': 'L', 'color': AppColors.pending};
      default:
        return {'text': '?', 'color': AppColors.ash};
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusStyle = _getStatusStyle(student.status);
    return Container(
      margin: EdgeInsets.only(bottom: ScreenUtilHelper.height(1.0)), // ScreenUtilHelper
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.secondaryAccentLight,width: 2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.all(ScreenUtilHelper.width(8.0)), // ScreenUtilHelper
            child: SizedBox(
              width: ScreenUtilHelper.width(70), // ScreenUtilHelper
              height: ScreenUtilHelper.height(70), // ScreenUtilHelper
              child: ClipRRect(
                borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8.0)), // ScreenUtilHelper
                child: Image.asset(
                  student.profileImagePath,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    decoration: BoxDecoration(
                      color: AppColors.cloud,
                      borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(8.0)), // ScreenUtilHelper
                    ),
                    child: Icon(
                      Icons.person,
                      size: ScreenUtilHelper.scaleAll(40), // ScreenUtilHelper
                      color: AppColors.stone,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.fromLTRB(
                0,
                ScreenUtilHelper.height(8), // ScreenUtilHelper
                ScreenUtilHelper.width(8), // ScreenUtilHelper
                ScreenUtilHelper.height(8), // ScreenUtilHelper
              ),
              child: Container(
                padding: EdgeInsets.all(ScreenUtilHelper.width(8.0)), // ScreenUtilHelper
                decoration: BoxDecoration(
                  color: AppColors.secondaryAccentLight.withAlpha(100),
                  borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(5)), // ScreenUtilHelper
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            student.id,
                            style: TextStyle(
                              fontSize: ScreenUtilHelper.fontSize(AppStyles.size.small), // ScreenUtilHelper
                              fontWeight: AppStyles.weight.emphasis,
                              color: AppColors.black,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: ScreenUtilHelper.height(4)), // ScreenUtilHelper
                          Text(
                            student.name,
                            style: TextStyle(
                              fontSize: ScreenUtilHelper.fontSize(AppStyles.size.bodySmall), // ScreenUtilHelper
                              fontWeight: AppStyles.weight.medium,
                              color: AppColors.obsidian,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: ScreenUtilHelper.height(4)), // ScreenUtilHelper
                          Text(
                            student.details,
                            style: TextStyle(
                              fontSize: ScreenUtilHelper.fontSize(AppStyles.size.small), // ScreenUtilHelper
                              fontWeight: AppStyles.weight.regular,
                              color: AppColors.graphite,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: ScreenUtilHelper.width(8)), // ScreenUtilHelper
                    Container(
                      width: ScreenUtilHelper.width(45), // ScreenUtilHelper
                      height: ScreenUtilHelper.height(50), // ScreenUtilHelper
                      decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color:  AppColors.secondaryAccentLight,width: 2)
                      ),
                      child: Center(
                        child: Text(
                          statusStyle['text'],
                          style: TextStyle(
                            fontSize: ScreenUtilHelper.fontSize(AppStyles.size.heading), // ScreenUtilHelper
                            fontWeight: AppStyles.weight.strong,
                            color: statusStyle['color'],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
