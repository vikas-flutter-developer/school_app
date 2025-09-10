import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../core/utils/app_colors.dart';
import '../../core/utils/app_styles.dart';
import '../../core/utils/screen_util_helper.dart';
import 'model/attendance_model.dart';

class AttendanceCalendar extends StatelessWidget {
  final List<CalendarEvent> calendarData;
  final DateTime selectedMonth;

  const AttendanceCalendar({
    super.key,
    required this.calendarData,
    required this.selectedMonth,
  });

  @override
  Widget build(BuildContext context) {
    ScreenUtilHelper.init(context);

    // Hardcoded attendance data, as per your request
    List<int> presentDates = [
      1, 3, 4, 5, 7, 8, 10, 12, 14, 17, 19, 20, 21, 22, 24, 26, 29
    ];
    List<int> absentDates = [11, 18, 25];
    List<int> holidayDates = [9, 15];

    Color presentColor = AppColors.mintGreen;
    Color absentColor = AppColors.attendanceAbsent;
    Color holidayColor = AppColors.attendanceHoliday;

    double circleSize = ScreenUtilHelper.scaleWidth(34);
    double fontSize = ScreenUtilHelper.fontSize(12);

    // Calculate the number of days in the selected month
    final int daysInMonth = DateTime(selectedMonth.year, selectedMonth.month + 1, 0).day;
    final DateTime firstDayOfMonth = DateTime(selectedMonth.year, selectedMonth.month, 1);

    // Calculate padding before the first day
    int firstWeekday = firstDayOfMonth.weekday;
    int adjustedFirstWeekday = firstWeekday == 7 ? 0 : firstWeekday;
    List<String> dayNames = ['M', 'T', 'W', 'T', 'F', 'S', 'S'];
    int paddingDays = adjustedFirstWeekday - 1;
    if (paddingDays == -1) {
      paddingDays = 6;
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ScreenUtilHelper.width(8)),
      child: Column(
        children: [
          Row(
            children: dayNames
                .map(
                  (dayName) => Expanded(
                child: Center(
                  child: Text(
                    dayName,
                    style: AppStyles.small.copyWith(fontSize: fontSize),
                  ),
                ),
              ),
            )
                .toList(),
          ),
          SizedBox(height: ScreenUtilHelper.height(4)),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              crossAxisSpacing: ScreenUtilHelper.width(3),
              mainAxisSpacing: ScreenUtilHelper.height(1),
            ),
            itemCount: paddingDays + daysInMonth,
            itemBuilder: (context, index) {
              if (index < paddingDays) {
                return Container();
              }

              // Calculate the day of the month
              final int dayInt = index - paddingDays + 1;
              Color circleColor = Colors.transparent;

              // Use hardcoded lists to determine color
              if (presentDates.contains(dayInt)) {
                circleColor = presentColor;
              } else if (absentDates.contains(dayInt)) {
                circleColor = absentColor;
              } else if (holidayDates.contains(dayInt)) {
                circleColor = holidayColor;
              }

              return Center(
                child: Container(
                  width: circleSize,
                  height: circleSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.silver),
                    color: circleColor,
                  ),
                  child: Center(
                    child: Text(
                      dayInt.toString(),
                      style: AppStyles.small.copyWith(fontSize: fontSize),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}