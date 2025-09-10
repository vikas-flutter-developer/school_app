import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/app_styles.dart';
import '../../../../core/utils/screen_util_helper.dart';
import '../staff_management/model/staff_form_model.dart';

class DocumentsSection extends StatelessWidget {
  final StaffFormModel form;
  final void Function(String fieldName, String value) onFieldChanged;

  const DocumentsSection({
    super.key,
    required this.form,
    required this.onFieldChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: ScreenUtilHelper.width(12),
        vertical: ScreenUtilHelper.height(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Documents", style: AppStyles.sectionHeading),
          SizedBox(height: ScreenUtilHelper.height(20)),

          _buildTextField(
            label: "Adhar Card Number*",
            hint: "3455 4546 6575",
            initialValue: form.adharNumber,
            onChanged: (val) => onFieldChanged('adharNumber', val),
          ),
          SizedBox(height: ScreenUtilHelper.height(14)),

          _buildTextField(
            label: "Pancard Number*",
            hint: "ADLY1458L",
            initialValue: form.panNumber,
            onChanged: (val) => onFieldChanged('panNumber', val),
          ),
          SizedBox(height: ScreenUtilHelper.height(14)),

          _buildTextField(
            label: "Emergency Mobile Number *",
            hint: "+91 67589 64748",
            initialValue: form.emergencyMobileNumber,
            onChanged: (val) => onFieldChanged('emergencyMobileNumber', val),
          ),
          SizedBox(height: ScreenUtilHelper.height(20)),

          const Text("Upload ID Proof", style: AppStyles.uploadLabel),
          SizedBox(height: ScreenUtilHelper.height(6)),
          _buildDisabledUploadButton(),

          SizedBox(height: ScreenUtilHelper.height(20)),

          const Text("Upload Photo", style: AppStyles.uploadLabel),
          SizedBox(height: ScreenUtilHelper.height(6)),
          _buildDisabledUploadButton(),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    required String? initialValue,
    required ValueChanged<String> onChanged,
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
            initialValue: initialValue,
            readOnly: true,
            style: AppStyles.inputText,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: AppStyles.hint1,
              isDense: true,
              filled: true,
              fillColor: AppColors.transparent,
              contentPadding: EdgeInsets.symmetric(
                horizontal: ScreenUtilHelper.width(12),
                vertical: ScreenUtilHelper.height(8),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(0)),
                borderSide: const BorderSide(color: AppColors.border),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(0)),
                borderSide: const BorderSide(color: AppColors.border),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(4)),
                borderSide: const BorderSide(color: AppColors.border),
              ),
            ),
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }

  Widget _buildDisabledUploadButton() {
    return SizedBox(
      height: ScreenUtilHelper.height(40),
      width: ScreenUtilHelper.width(120),
      child: TextButton(
        onPressed: null,
        style: TextButton.styleFrom(
          backgroundColor: AppColors.white,
          disabledBackgroundColor: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ScreenUtilHelper.radius(0)),
            side: const BorderSide(color: AppColors.border),
          ),
        ),
        child: const Text("Upload", style: AppStyles.uploadButtonText),
      ),
    );
  }
}
