import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/screen_util_helper.dart';
import '../staff_management/model/employee_entity.dart';

class JoiningDetailsCard extends StatelessWidget {
  final EmployeeEntity employee;

  const JoiningDetailsCard({super.key, required this.employee});

  Widget infoRow(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            vertical: ScreenUtilHelper.height(10),
          ),
          child: Text(
            '$title - $value',
            style: AppStyles.body,
          ),
        ),
        const Divider(height: 1, color: AppColors.divider),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(18)),
      ),
      padding: EdgeInsets.all(ScreenUtilHelper.scaleAll(20)),
      margin: EdgeInsets.all(ScreenUtilHelper.scaleAll(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Joining Details',
            style: AppStyles.sectionTitle,
          ),
          SizedBox(height: ScreenUtilHelper.height(16)),
          infoRow('Joining Date', employee.joiningDate),
          infoRow('Employee Type', employee.employeeType),
          infoRow('Relieving Date', employee.relievingDate),
          infoRow('Renewals', employee.renewals),
          infoRow('Verification', employee.verification),
        ],
      ),
    );
  }
}
