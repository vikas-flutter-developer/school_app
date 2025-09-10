import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/screen_util_helper.dart';
import '../staff_management/bloc/staff_form_bloc.dart';
import '../staff_management/bloc/staff_form_event.dart';
import '../staff_management/model/staff_form_model.dart';
import 'submit_created_profile.dart';

class AdminDetailsSection extends StatelessWidget {
  final StaffFormModel form;

  const AdminDetailsSection({super.key, required this.form});

  void _showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        // Yahan updated DialogDemoScreen widget ka istemal ho raha hai
        return DialogDemoScreen(
          onConfirm: () {
            // "Yes" click hone par yeh code chalega
            context.read<StaffFormBloc>().add(SubmitStaffForm());
          },
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            left: ScreenUtilHelper.width(16),
            top: ScreenUtilHelper.height(16),
          ),
          child: Text("Admin Details", style: AppStyles.sectionHeading),
        ),
        SizedBox(height: ScreenUtilHelper.height(10)),

        Container(
          margin: EdgeInsets.symmetric(horizontal: ScreenUtilHelper.width(12)),
          padding: EdgeInsets.symmetric(
            horizontal: ScreenUtilHelper.width(16),
            vertical: ScreenUtilHelper.height(20),
          ),
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(20)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildDisabledField(label: "Joining Date*", value: form.dateOfJoining),
              SizedBox(height: ScreenUtilHelper.height(16)),
              _buildDisabledField(label: "Reliving Date", value: form.relivingDate),
              SizedBox(height: ScreenUtilHelper.height(16)),
              _buildDisabledDropdown(label: "Verification", value: form.verificationStatus),
              SizedBox(height: ScreenUtilHelper.height(16)),
              _buildDisabledMultilineField(
                label: "Any Message",
                value: form.remarks,
                hint: "Collect documents at the time of joining",
              ),
            ],
          ),
        ),
        SizedBox(height: ScreenUtilHelper.height(20)),

        Center(
          child: OutlinedButton(
            onPressed: () {
              _showConfirmationDialog(context);
            },
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtilHelper.width(48),
                vertical: ScreenUtilHelper.height(14),
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(6)),
              ),
              side: const BorderSide(color: AppColors.primary),
            ),
            child: const Text("Submit", style: AppStyles.buttonText),
          ),
        ),
        SizedBox(height: ScreenUtilHelper.height(20)),
      ],
    );
  }

  // --- Helper widgets (Unchanged) ---

  Widget _buildDisabledField({required String label, required String value}) {
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
                vertical: ScreenUtilHelper.height(8),
              ),
              filled: true,
              fillColor: AppColors.cardBackground,
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: AppColors.border),
                borderRadius: BorderRadius.circular(0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: AppColors.border),
                borderRadius: BorderRadius.circular(0),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDisabledDropdown({required String label, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppStyles.body),
        SizedBox(height: ScreenUtilHelper.height(6)),
        SizedBox(
          height: ScreenUtilHelper.height(34),
          width: ScreenUtilHelper.width(371),
          child: DropdownButtonFormField<String>(
            value: value,
            onChanged: null,
            items: const [
              DropdownMenuItem(value: 'Verified', child: Text('Verified')),
              DropdownMenuItem(value: 'Pending', child: Text('Pending')),
              DropdownMenuItem(value: 'Rejected', child: Text('Rejected')),
            ],
            icon: const Icon(Icons.expand_more_rounded, color: AppColors.grey),
            decoration: InputDecoration(
              isDense: true,
              filled: true,
              fillColor: AppColors.cardBackground,
              contentPadding: EdgeInsets.symmetric(
                horizontal: ScreenUtilHelper.width(12),
                vertical: ScreenUtilHelper.height(8),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0),
                borderSide: const BorderSide(color: AppColors.border),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0),
                borderSide: const BorderSide(color: AppColors.border),
              ),
            ),
            style: AppStyles.textField,
            dropdownColor: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildDisabledMultilineField({
    required String label,
    required String value,
    required String hint,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppStyles.body),
        SizedBox(height: ScreenUtilHelper.height(6)),
        SizedBox(
          height: ScreenUtilHelper.height(95),
          width: ScreenUtilHelper.width(371),
          child: TextFormField(
            initialValue: value,
            readOnly: true,
            maxLines: 4,
            style: AppStyles.textField,
            decoration: InputDecoration(
              isDense: true,
              hintText: hint,
              hintStyle: AppStyles.hint,
              contentPadding: EdgeInsets.symmetric(
                horizontal: ScreenUtilHelper.width(12),
                vertical: ScreenUtilHelper.height(14),
              ),
              filled: true,
              fillColor: AppColors.cardBackground,
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: AppColors.border),
                borderRadius: BorderRadius.circular(0),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: AppColors.border),
                borderRadius: BorderRadius.circular(0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}