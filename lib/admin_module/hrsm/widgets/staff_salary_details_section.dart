import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/screen_util_helper.dart';
import '../staff_management/model/staff_form_model.dart';

class SalaryDetailsSection extends StatelessWidget {
  final StaffFormModel form;

  const SalaryDetailsSection({super.key, required this.form});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtilHelper.width(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Salary  Details",
            style: AppStyles.sectionHeading,
          ),
          SizedBox(height: ScreenUtilHelper.height(12)),
          Container(
            height: ScreenUtilHelper.height(320),
            width: double.infinity,
            decoration: BoxDecoration(
              color: AppColors.cardBackground,
              borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(20)),
            ),
            padding: EdgeInsets.symmetric(
              horizontal: ScreenUtilHelper.width(16),
              vertical: ScreenUtilHelper.height(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDisabledField(
                  label: "Salary Amount*",
                  value: form.salary,
                  prefix: '₹ ',
                ),
                SizedBox(height: ScreenUtilHelper.height(16)),
                _buildDisabledField(
                  label: "PF Deduction*",
                  value: form.pfDeduction,
                  prefix: '₹ ',
                ),
                SizedBox(height: ScreenUtilHelper.height(16)),
                _buildDisabledField(
                  label: "Bank account number*",
                  value: form.accountNumber,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDisabledField({
    required String label,
    required String value,
    String? prefix,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppStyles.body),
        SizedBox(height: ScreenUtilHelper.height(6)),
        SizedBox(
          height: ScreenUtilHelper.height(34),
          width: ScreenUtilHelper.width(371),
          child: TextFormField(
            initialValue: value,
            readOnly: true,
            style: AppStyles.textField,
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.symmetric(
                horizontal: ScreenUtilHelper.width(12),
                vertical: ScreenUtilHelper.height(14),
              ),
              prefixText: prefix,
              prefixStyle: AppStyles.textField,
              filled: true,
              fillColor: Colors.transparent,
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: AppColors.border),
                borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: AppColors.border),
                borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(0)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
