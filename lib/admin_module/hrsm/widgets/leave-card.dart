import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/screen_util_helper.dart';
import '../staff_management/model/employee_entity.dart'; // ✅ Import helper

class LegendItem extends StatelessWidget {
  final Color color;
  final String label;

  const LegendItem({super.key, required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: ScreenUtilHelper.radius(5),
          backgroundColor: color,
        ),
        SizedBox(width: ScreenUtilHelper.width(6)),
        Text(label, style: AppStyles.caption),
      ],
    );
  }
}

class LeavesCard extends StatelessWidget {
  final EmployeeEntity employee;

  const LeavesCard({super.key, required this.employee});

  Widget leaveRow(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: ScreenUtilHelper.height(10)),
          child: Text('$title - $value', style: AppStyles.body),
        ),
        const Divider(height: 1, color: AppColors.divider),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final double attendancePercent = 0.76;
    final double leavesPercent = 0.18;
    final double halfDaysPercent = 0.06;

    final double radius = ScreenUtilHelper.scaleAll(70);
    final double size = radius * 2;

    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(12)),
      ),
      padding: EdgeInsets.all(ScreenUtilHelper.scaleAll(20)),
      margin: EdgeInsets.symmetric(
        vertical: ScreenUtilHelper.height(10),
        horizontal: ScreenUtilHelper.width(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Leaves", style: AppStyles.sectionTitle),
          SizedBox(height: ScreenUtilHelper.height(16)),
          leaveRow("Total", employee.leaves.total.toString()),
          leaveRow("Sick leaves", employee.leaves.sick.toString()),
          leaveRow("Casual leaves", employee.leaves.casual.toString()),
          leaveRow("Remaining", employee.leaves.remaining.toString()),
          SizedBox(height: ScreenUtilHelper.height(22)),
          Center(
            child: SizedBox(
              height: size,
              width: size,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CircularPercentIndicator(
                    radius: radius,
                    lineWidth: ScreenUtilHelper.scaleAll(10),
                    percent: 1,
                    progressColor: AppColors.greyLight,
                    backgroundColor: Colors.transparent,
                  ),
                  CircularPercentIndicator(
                    radius: radius,
                    lineWidth: ScreenUtilHelper.scaleAll(10),
                    percent: attendancePercent,
                    progressColor: AppColors.attendanceBlue,
                    backgroundColor: Colors.transparent,
                    circularStrokeCap: CircularStrokeCap.round,
                  ),
                  Transform.rotate(
                    angle: 2 * 3.14159 * attendancePercent,
                    child: CircularPercentIndicator(
                      radius: radius,
                      lineWidth: ScreenUtilHelper.scaleAll(10),
                      percent: leavesPercent,
                      progressColor: AppColors.leaveCyan,
                      backgroundColor: Colors.transparent,
                      circularStrokeCap: CircularStrokeCap.round,
                    ),
                  ),
                  Transform.rotate(
                    angle: 2 * 3.14159 * (attendancePercent + leavesPercent),
                    child: CircularPercentIndicator(
                      radius: radius,
                      lineWidth: ScreenUtilHelper.scaleAll(10),
                      percent: halfDaysPercent,
                      progressColor: AppColors.halfDayRed,
                      backgroundColor: Colors.transparent,
                      circularStrokeCap: CircularStrokeCap.round,
                    ),
                  ),
                  Text(
                    "${(attendancePercent * 100).toInt()}%",
                    style: AppStyles.percentage,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: ScreenUtilHelper.height(20)),
          const Divider(height: 1, color: AppColors.divider),
          SizedBox(height: ScreenUtilHelper.height(12)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: const [
              LegendItem(color: AppColors.attendanceBlue, label: 'Attendance'),
              LegendItem(color: AppColors.leaveCyan, label: 'Leaves'),
              LegendItem(color: AppColors.halfDayRed, label: 'Half days'),
            ],
          ),
        ],
      ),
    );
  }
}
