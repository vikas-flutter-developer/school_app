import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/screen_util_helper.dart';
import '../staff_management/model/employee_entity.dart';

class SalaryDetailsCard extends StatelessWidget {
  final EmployeeEntity employee;

  const SalaryDetailsCard({super.key, required this.employee});

  Widget infoRow(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: ScreenUtilHelper.height(12)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppStyles.body),
              SizedBox(height: ScreenUtilHelper.height(4)),
              Text(value, style: AppStyles.body),
            ],
          ),
        ),
        const Divider(height: 1, color: AppColors.divider),
      ],
    );
  }

  Widget doubleInfoRow(
      String title1, String value1, String title2, String value2) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: ScreenUtilHelper.height(12)),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title1, style: AppStyles.body),
                    SizedBox(height: ScreenUtilHelper.height(4)),
                    Text(value1, style: AppStyles.body),
                  ],
                ),
              ),
              SizedBox(width: ScreenUtilHelper.width(16)),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title2, style: AppStyles.body),
                    SizedBox(height: ScreenUtilHelper.height(4)),
                    Text(value2, style: AppStyles.body),
                  ],
                ),
              ),
            ],
          ),
        ),
        const Divider(height: 1, color: AppColors.divider),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(ScreenUtilHelper.width(12)),
      padding: EdgeInsets.all(ScreenUtilHelper.width(16)),
      decoration: BoxDecoration(
        color: AppColors.cardBackground,
        borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(12)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Salary Details', style: AppStyles.sectionTitle),
          SizedBox(height: ScreenUtilHelper.height(16)),
          Text(
            'CTC - ${employee.salary.ctc}\n'
                'Fixed - ${employee.salary.fixed}\n'
                'Variable - ${employee.salary.variable}',
            style: AppStyles.body,
          ),
          SizedBox(height: ScreenUtilHelper.height(12)),
          const Divider(height: 1, color: AppColors.divider),

          infoRow('Benefits', employee.salary.benefits.toString()),
          infoRow('PDF Deduction', employee.salary.deduction.toString()),

          SizedBox(height: ScreenUtilHelper.height(12)),
          const Text('Payment Details', style: AppStyles.subsectionTitle),
          SizedBox(height: ScreenUtilHelper.height(16)),

          doubleInfoRow(
            'Bank name',
            employee.bankDetails.bankName,
            'Branch',
            employee.bankDetails.branch,
          ),

          infoRow('Account Type', employee.bankDetails.accountType),
          infoRow('Bank account number', employee.bankDetails.accountNumber.toString()),
          infoRow('IFSC Code', employee.bankDetails.ifscCode),
        ],
      ),
    );
  }
}
