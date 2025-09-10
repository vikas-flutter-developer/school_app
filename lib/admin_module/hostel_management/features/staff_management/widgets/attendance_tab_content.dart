import 'package:edudibon_flutter_bloc/core/utils/app_styles.dart';
import 'package:flutter/material.dart';
import '../../../../../core/utils/app_colors.dart';
import '../../../../../core/utils/screen_util_helper.dart';
import '../models/attendance_record.dart';

class AttendanceTabContent extends StatelessWidget {
  final List<AttendanceRecord> attendanceList;

  const AttendanceTabContent({super.key, required this.attendanceList});

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context);

    if (attendanceList.isEmpty) {
      return const Center(child: Text("No attendance records available."));
    }
    return ListView.builder(
      padding: EdgeInsets.only(
          top: ScreenUtilHelper.height(8.0),
          bottom: ScreenUtilHelper.height(16.0)),
      itemCount: attendanceList.length,
      itemBuilder: (context, index) {
        final record = attendanceList[index];
        Color timeColor;
        String timePrefix;

        if (record.checkInTime.startsWith("out")) {
          timeColor = AppColors.pending;
          timePrefix = "";
        } else if (record.checkInTime == "7:30am") {
          timeColor = AppColors.error;
          timePrefix = "in ";
        } else {
          timeColor = AppColors.success;
          timePrefix = "in ";
        }

        return Padding(
          padding: EdgeInsets.only(
            left: ScreenUtilHelper.width(16.0),
            right: ScreenUtilHelper.width(16.0),
            bottom: ScreenUtilHelper.height(8.0),
          ),
          child: Container(
            width: double.infinity,
            height: ScreenUtilHelper.height(40),
            color: AppColors.ivory,
            child: Padding(
              padding: EdgeInsets.all(ScreenUtilHelper.width(8.0)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    record.name,
                    style: AppStyles.bodySmallEmphasis.copyWith(color: AppColors.black),
                  ),
                  Text(
                    "$timePrefix${record.checkInTime}",
                    style: AppStyles.bodySmallEmphasis.copyWith(color: timeColor),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}