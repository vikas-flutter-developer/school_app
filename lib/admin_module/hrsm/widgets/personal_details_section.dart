import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/screen_util_helper.dart';
import '../staff_management/bloc/staff_form_bloc.dart';
import '../staff_management/bloc/staff_form_event.dart';
import '../staff_management/model/staff_form_model.dart';

class PersonalDetailsSection extends StatelessWidget {
  final StaffFormModel form;

  const PersonalDetailsSection({super.key, required this.form});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtilHelper.width(16),
        vertical: ScreenUtilHelper.height(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildField(
            context,
            label: "Name *",
            initialValue: form.name,
            onChanged: (val) => context.read<StaffFormBloc>().add(
              StaffFormFieldChanged('name', val),
            ),
          ),
          _buildField(
            context,
            label: "Mobile Number *",
            initialValue: form.mobile,
            keyboardType: TextInputType.phone,
            onChanged: (val) => context.read<StaffFormBloc>().add(
              StaffFormFieldChanged('mobile', val),
            ),
          ),
          _buildField(
            context,
            label: "Email Id*",
            initialValue: form.email,
            keyboardType: TextInputType.emailAddress,
            onChanged: (val) => context.read<StaffFormBloc>().add(
              StaffFormFieldChanged('email', val),
            ),
          ),
          _buildDropdownField(
            context,
            label: "Department *",
            value: form.department.isNotEmpty &&
                ['Kitchen', 'Science', 'Math', 'English', 'History']
                    .contains(form.department)
                ? form.department
                : null,
            items: const ['Kitchen', 'Science', 'Math', 'English', 'History'],
            onChanged: (val) => context.read<StaffFormBloc>().add(
              StaffFormFieldChanged('department', val),
            ),
            hintText: 'Select Department',
          ),
          _buildDropdownField(
            context,
            label: "Academic Year *",
            value: form.academicYear.isNotEmpty &&
                ['2024 - 2025', '2025 - 2026']
                    .contains(form.academicYear)
                ? form.academicYear
                : null,
            items: const ['2024 - 2025', '2025 - 2026'],
            onChanged: (val) => context.read<StaffFormBloc>().add(
              StaffFormFieldChanged('academicYear', val),
            ),
            hintText: 'Select Academic Year',
          ),
          _buildField(
            context,
            label: "Permanent Address *",
            initialValue: form.address,
            maxLines: 2,
            height: ScreenUtilHelper.height(64),
            onChanged: (val) => context.read<StaffFormBloc>().add(
              StaffFormFieldChanged('address', val),
            ),
          ),
          _buildDropdownField(
            context,
            label: "Employee Type*",
            value: form.employeeType.isNotEmpty &&
                ['Full Time', 'Part Time', 'Contract']
                    .contains(form.employeeType)
                ? form.employeeType
                : null,
            items: const ['Full Time', 'Part Time', 'Contract'],
            onChanged: (val) => context.read<StaffFormBloc>().add(
              StaffFormFieldChanged('employeeType', val),
            ),
          ),
          _buildField(
            context,
            label: "Highest Education*",
            initialValue: form.education,
            onChanged: (val) => context.read<StaffFormBloc>().add(
              StaffFormFieldChanged('education', val),
            ),
          ),
          _buildField(
            context,
            label: "Grades / Percentage*",
            initialValue: form.percentage,
            keyboardType: TextInputType.number,
            onChanged: (val) => context.read<StaffFormBloc>().add(
              StaffFormFieldChanged('percentage', val),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildField(
      BuildContext context, {
        required String label,
        required String? initialValue,
        required Function(String) onChanged,
        TextInputType keyboardType = TextInputType.text,
        int maxLines = 1,
        double? height,
      }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: ScreenUtilHelper.height(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppStyles.body),
          SizedBox(height: ScreenUtilHelper.height(6)),
          SizedBox(
            height: height ?? ScreenUtilHelper.height(34),
            width: ScreenUtilHelper.width(371),
            child: TextFormField(
              initialValue: initialValue,
              onChanged: onChanged,
              keyboardType: keyboardType,
              maxLines: maxLines,
              style: AppStyles.body,
              decoration: InputDecoration(
                isDense: true,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: ScreenUtilHelper.width(12),
                  vertical: ScreenUtilHelper.height(14),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.border),
                  borderRadius: BorderRadius.circular(0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.borderFocused),
                  borderRadius: BorderRadius.circular(0),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownField(
      BuildContext context, {
        required String label,
        required String? value,
        required List<String> items,
        required Function(String) onChanged,
        String? hintText,
      }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: ScreenUtilHelper.height(8)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppStyles.body),
          SizedBox(height: ScreenUtilHelper.height(6)),
          SizedBox(
            height: ScreenUtilHelper.height(40),
            width: ScreenUtilHelper.width(371),
            child: DropdownButtonFormField<String>(
              value: value,
              onChanged: (val) => val != null ? onChanged(val) : null,
              items: items
                  .map((item) => DropdownMenuItem(
                value: item,
                child: Text(
                  item,
                  overflow: TextOverflow.ellipsis,
                ),
              ))
                  .toList(),
              icon: const Icon(Icons.keyboard_arrow_down_rounded,
                  color: AppColors.iconGray),
              decoration: InputDecoration(
                isDense: false,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: ScreenUtilHelper.width(12),
                  vertical: ScreenUtilHelper.height(14),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.border),
                  borderRadius: BorderRadius.circular(0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.borderFocused),
                  borderRadius: BorderRadius.circular(0),
                ),
                hintText: hintText,
                hintStyle: AppStyles.hint1,
              ),
              style: AppStyles.body,
              dropdownColor: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }
}
