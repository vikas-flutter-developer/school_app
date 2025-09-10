import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/screen_util_helper.dart';
import '../staff_management/model/employee_entity.dart'; // ✅ Import

class EmployeeInfoCard extends StatelessWidget {
  final EmployeeEntity employee;

  const EmployeeInfoCard({super.key, required this.employee});

  Widget infoRow(String title, String value) {
    return Container(
      width: double.infinity,
      color: AppColors.cardBackground,
      padding: EdgeInsets.symmetric(
        vertical: ScreenUtilHelper.height(12),
        horizontal: ScreenUtilHelper.width(12),
      ),
      child: Text(
        "$title - $value",
        style: AppStyles.body,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: ScreenUtilHelper.width(16),
        vertical: ScreenUtilHelper.height(12),
      ),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(12)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(
              ScreenUtilHelper.width(12),
              ScreenUtilHelper.height(16),
              ScreenUtilHelper.width(12),
              ScreenUtilHelper.height(8),
            ),
            child: const Text(
              "Employee Profile",
              style: AppStyles.sectionTitle,
            ),
          ),
          const Divider(height: 1, color: AppColors.divider),
          infoRow("Name", employee.name),
          const Divider(height: 1, color: AppColors.divider),
          infoRow("Mobile", employee.mobile),
          const Divider(height: 1, color: AppColors.divider),
          infoRow("Email Id", employee.email),
          const Divider(height: 1, color: AppColors.divider),
          infoRow("Department", employee.department),
          const Divider(height: 1, color: AppColors.divider),
          infoRow("Sub Department", employee.subDepartment),
          const Divider(height: 1, color: AppColors.divider),
          infoRow("Subject", employee.subject),
          const Divider(height: 1, color: AppColors.divider),
          infoRow("Address", employee.address),
        ],
      ),
    );
  }
}
