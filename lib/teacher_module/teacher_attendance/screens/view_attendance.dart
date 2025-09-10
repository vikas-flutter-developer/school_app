import 'package:edudibon_flutter_bloc/core/utils/app_colors.dart';
import 'package:edudibon_flutter_bloc/core/utils/app_styles.dart';
import 'package:edudibon_flutter_bloc/core/utils/screen_util_helper.dart'; // ✅ Required
import 'package:edudibon_flutter_bloc/teacher_module/teacher_attendance/screens/update_attendance.dart'
    show UpdateAttendanceScreen;
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../routes/app_routes.dart';
import 'attendance_details.dart';
import 'attendance_report.dart';

class ViewAttendanceScreen extends StatelessWidget {
  const ViewAttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context); // ✅ Initialize helper

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
         backgroundColor: AppColors.white,
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'assets/images/edudibon.png',
              height: ScreenUtilHelper.height(30), // ScreenUtilHelper
              fit: BoxFit.contain,
            ),
            Stack(
              alignment: Alignment.topRight,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.notifications_none,
                    color: AppColors.ash,
                    size: 30,
                  ),
                  onPressed: () {},
                ),
                Center(
                  child: Container(
                    margin: EdgeInsets.only(
                      top: ScreenUtilHelper.height(1), // ScreenUtilHelper
                      right: ScreenUtilHelper.width(5), // ScreenUtilHelper
                    ),
                    decoration: const BoxDecoration(
                      color: AppColors.error,
                      shape: BoxShape.circle,
                    ),
                    width: ScreenUtilHelper.width(15), // ScreenUtilHelper
                    height: ScreenUtilHelper.height(15), // ScreenUtilHelper
                    child: Center(
                      child: Text(
                        "3",
                        style: TextStyle(
                          fontSize: ScreenUtilHelper.fontSize(AppStyles.size.tiny), // ScreenUtilHelper
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: ScreenUtilHelper.width(16), // ScreenUtilHelper
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: ScreenUtilHelper.height(5), // ScreenUtilHelper
                bottom: ScreenUtilHelper.height(30), // ScreenUtilHelper
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: AppColors.blackHighEmphasis,
                      size: 20,
                    ),
                    onPressed: ()=> GoRouter.of(context).pop(),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    splashRadius: ScreenUtilHelper.radius(20), // ScreenUtilHelper
                  ),
                  SizedBox(width: ScreenUtilHelper.width(8)), // ScreenUtilHelper
                  Text(
                    'Attendance',
                    style: TextStyle(
                      fontSize: ScreenUtilHelper.fontSize(AppStyles.size.bodyLarge), // ScreenUtilHelper
                      fontWeight: AppStyles.weight.emphasis,
                      color: AppColors.black,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: ScreenUtilHelper.height(30)), // ScreenUtilHelper
            Column(
              children: [
                _AttendanceTile(
                  title: 'Update Attendance',
                  onTap: () =>context.push(AppRoutes.updateAttendance),

                ),
                SizedBox(height: ScreenUtilHelper.height(20)), // ScreenUtilHelper
                _AttendanceTile(
                  title: 'Attendance Details',
                  onTap: () =>context.push(AppRoutes.attendanceDetails),

                ),
                SizedBox(height: ScreenUtilHelper.height(20)), // ScreenUtilHelper
                _AttendanceTile(
                  title: 'Attendance Report',
                  onTap: () =>context.push(AppRoutes.attendanceReport),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _AttendanceTile extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _AttendanceTile({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: ScreenUtilHelper.width(310), // ScreenUtilHelper
          height: ScreenUtilHelper.height(78), // ScreenUtilHelper
          decoration: BoxDecoration(
            color: AppColors.primaryMedium.withAlpha(12),
            border: Border.all(color: AppColors.primaryMedium.withAlpha(36),width: 1),
            borderRadius: BorderRadius.circular(
              ScreenUtilHelper.radius(5), // ScreenUtilHelper
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(ScreenUtilHelper.scaleAll(16)), // ScreenUtilHelper
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: ScreenUtilHelper.fontSize(AppStyles.size.bodySmall), // ScreenUtilHelper
                    fontWeight: AppStyles.weight.emphasis,
                    color: AppColors.black,
                  ),
                ),
                const Icon(Icons.arrow_forward_ios),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
